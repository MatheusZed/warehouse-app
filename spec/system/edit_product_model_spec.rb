require 'rails_helper'

describe 'User edits product model' do
  let(:supplier) { create(:supplier, fantasy_name: "Maria") }

  it 'Visitor not sees the menu' do
    # Arrange
    pm1 = create(:product_model, supplier: supplier)

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

    # Act
    visit edit_product_model_path(supplier.id)

    # Assert
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'through the list screen' do
    # Arrange
    pm1 = create(:product_model, supplier: supplier)
    pm2 = create(:product_model, supplier: supplier)
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'See suppliers'
    click_on 'Maria'
    click_on 'Edit', id: "edit_pm-#{pm1.id}"

    # Assert
    expect(current_path).to eq edit_product_model_path(pm1.id)
    expect(page).to have_content 'Edit Product Model'
  end

  it 'successfully' do
    # Arrange
    pm1 = create(:product_model, supplier: supplier)
    pm2 = create(:product_model, supplier: supplier)
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'See suppliers'
    click_on 'Maria'
    click_on 'Edit', id: "edit_pm-#{pm2.id}"
    fill_in 'Nome',	with: 'Ossos de galinha'
    fill_in 'Peso',	with: '100'
    click_on 'Save'

    # Assert
    expect(current_path).to eq product_model_path(pm2.id)
    expect(page).to have_content 'Successfully edited product model'
    expect(page).to have_content 'Ossos de galinha'
    expect(page).to have_content 'Peso: 100'
  end

  it "and can't edit" do
    # Arrange
    pm1 = create(:product_model, supplier: supplier)
    pm2 = create(:product_model, supplier: supplier)
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'See suppliers'
    click_on 'Maria'
    click_on 'Edit', id: "edit_pm-#{pm1.id}"
    fill_in 'Nome',	with: ''
    fill_in 'Peso',	with: '0'
    click_on 'Save'

    # Assert
    expect(page).not_to have_content 'Successfully edited product model'
    expect(page).to have_content "It wasn't possible to edit the product model"
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Peso deve ser maior que 0'
  end
end
