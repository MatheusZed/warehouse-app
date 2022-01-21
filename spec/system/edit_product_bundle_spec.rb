require 'rails_helper'

describe 'User edits product bundle' do
  let(:supplier) { create(:supplier, fantasy_name: "Maria") }
  
  it 'Visitor not sees the menu' do
    # Arrange
    pm1 = create(:product_model, supplier: supplier)
    pm2 = create(:product_model, supplier: supplier)
    pm3 = create(:product_model, supplier: supplier)
    pb = create(:product_bundle, name: "Kit Bruxaria", product_model_ids: [pm1.id, pm2.id])    

    # Act
    visit root_path
    click_on 'See suppliers'
    click_on 'Maria'

    # Assert
    expect(page).not_to have_link 'Edit'
  end

  it "Visitor don't access the form directly" do
    # Arrange
    pm1 = create(:product_model, supplier: supplier)
    pm2 = create(:product_model, supplier: supplier)
    pm3 = create(:product_model, supplier: supplier)
    pb = create(:product_bundle, name: "Kit Bruxaria", product_model_ids: [pm1.id, pm2.id])

    # Act
    visit edit_product_bundle_path(supplier.id)

    # Assert
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'through the list screen' do
    # Arrange
    pm1 = create(:product_model, supplier: supplier)
    pm2 = create(:product_model, supplier: supplier)
    pm3 = create(:product_model, supplier: supplier)
    pb1 = create(:product_bundle, name: "Kit Bruxaria", product_model_ids: [pm1.id, pm2.id])
    pb2 = create(:product_bundle, name: "Kit Xariabru", product_model_ids: [pm2.id, pm3.id])
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'See suppliers'
    click_on 'Maria'
    click_on 'Edit', id: "edit_pb-#{pb1.id}"

    # Assert
    expect(current_path).to eq edit_product_bundle_path(pb1.id)
    expect(page).to have_content 'Edit Product Bundle'
  end

  it 'successfully' do
    # Arrange
    pm1 = create(:product_model, name: "Migalhas de pao", supplier: supplier)
    pm2 = create(:product_model, name: "Osso de Frango", supplier: supplier)
    pm3 = create(:product_model, name: "Doces", supplier: supplier)
    pb1 = create(:product_bundle, name: "Kit Bruxaria", product_model_ids: [pm1.id, pm2.id])
    pb2 = create(:product_bundle, name: "Kit Xariabru", product_model_ids: [pm2.id, pm3.id])
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'See suppliers'
    click_on 'Maria'
    click_on 'Edit', id: "edit_pb-#{pb1.id}"
    fill_in 'Nome',	with: 'Kit Bruxaria Personalizado'
    uncheck 'Osso de Frango'
    check 'Doces'
    click_on 'Save'

    # Assert
    expect(current_path).to eq product_bundle_path(pb1.id)
    expect(page).to have_content 'Successfully edited product bundle'
    expect(page).not_to have_content 'Ossos de galinha'
    expect(page).to have_content 'Doces'
    expect(page).to have_content 'Kit Bruxaria Personalizado'
  end

  it "and can't edit" do
    # Arrange
    pm1 = create(:product_model, name: "Migalhas de pao", supplier: supplier)
    pm2 = create(:product_model, name: "Osso de Frango", supplier: supplier)
    pm3 = create(:product_model, name: "Doces", supplier: supplier)
    pb1 = create(:product_bundle, name: "Kit Bruxaria", product_model_ids: [pm1.id, pm2.id])
    pb2 = create(:product_bundle, name: "Kit Xariabru", product_model_ids: [pm2.id, pm3.id])
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'See suppliers'
    click_on 'Maria'
    click_on 'Edit', id: "edit_pb-#{pb1.id}"
    fill_in 'Nome',	with: ''
    uncheck 'Osso de Frango'
    click_on 'Save'

    # Assert
    expect(page).not_to have_content 'Successfully edited product bundle'
    expect(page).to have_content "It wasn't possible to edit the product bundle"
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Modelo de Produto : é necessario selecionar no minimo 2'
  end
end
