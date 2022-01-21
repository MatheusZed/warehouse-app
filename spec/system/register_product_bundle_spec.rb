require 'rails_helper'

describe 'User registers a bundle' do
  let(:supplier) { create(:supplier) }

  it 'Visitor not sees the menu' do
    # Act
    visit root_path

    # Assert
    expect(page).not_to have_link 'Register new product bundle'
  end

  it "Visitor don't access the form directly" do
    # Act
    visit new_product_bundle_path

    # Assert
    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'throught the link in homepage' do
    # Arrange
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Register new product bundle'

    # Assert
    expect(page).to have_content 'New Product Bundle'
    expect(page).to have_field 'Nome'
    expect(page).to have_button 'Save'
  end

  it 'Successfully' do
    # Arrange
    create(:product_model, name: "Vinho Tinto Miolo", supplier: supplier)
    create(:product_model, name: "Taça para vinho tinto", supplier: supplier)
    create(:product_model, name: "Saco de batata rustica", supplier: supplier)
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Register new product bundle'
    fill_in 'Nome',	with: 'Kit Degustacao Miolo'
    check 'Vinho Tinto Miolo'
    check 'Taça para vinho tinto'
    click_on 'Save'

    # Assert
    pb = ProductBundle.last
    expect(page).to have_content 'Successfully registered product bundle'
    expect(page).to have_content 'Kit Degustacao Miolo'
    expect(page).to have_content "Codigo SKU: #{pb.sku}"
    expect(page).to have_content 'Vinho Tinto Miolo'
    expect(page).to have_content 'Taça para vinho tinto'
    expect(page).not_to have_content 'Saco de batata rustica'
  end

  it 'and the fields are required' do
    # Arrange
    create(:product_model, name: "Migalhas de pao", supplier: supplier)
    create(:product_model, name: "Osso de Frango", supplier: supplier)
    create(:product_model, name: "Doces", supplier: supplier)
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Register new product bundle'
    fill_in 'Nome',	with: ''
    check 'Migalhas de pao'
    click_on 'Save'

    # Assert
    expect(page).not_to have_content 'Successfully registered product bundle'
    expect(page).to have_content "It wasn't possible to record the product bundle"
    expect(page).to have_content 'Nome não pode ficar em branco'
  end

  pending "and the supplier can't see the other supplier's product model" do
    # Arrange
    supplier2 = create(:supplier, fantasy_name: "Toys")
    pc1 = create(:product_category, name: 'Destilados')
    pc2 = create(:product_category, name: 'Action Figure')
    create(:product_model, name: 'Vinho Tinto Miolo', supplier: s1, product_category: pc1)
    create(:product_model, name: 'Taça para vinho tinto', supplier: s1, product_category: pc1)
    create(:product_model, name: 'Vinho Rose', supplier: s1, product_category: pc1)
    create(:product_model, name: 'Boneco do Batman', supplier: s2, product_category: pc2)
    create(:product_model, name: 'Boneco do Homem-Aranha', supplier: s2, product_category: pc2)
    create(:product_model, name: 'Boneco do Mutano', supplier: s2, product_category: pc2)
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Register new product bundle'
    select 'Toys', from: 'Fornecedor'

    # Assert
    expect(page).to have_content 'Boneco do Batman'
    expect(page).to have_content 'Boneco do Homem-Aranha'
    expect(page).to have_content 'Boneco do Mutano'
    expect(page).not_to have_content 'Vinho Tinto Miolo'
    expect(page).not_to have_content 'Taça para vinho tinto'
    expect(page).not_to have_content 'Vinho Rose'
  end
end
