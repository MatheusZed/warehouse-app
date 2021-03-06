require 'rails_helper'

describe 'User register product model' do
  it 'Visitor not sees the menu' do
    # Act
    visit root_path

    # Assert
    expect(page).not_to have_link 'Register new product model'
  end

  it "Visitor don't access the form directly" do
    # Act
    visit new_product_model_path

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
    click_on 'Register new product model'

    # Assert
    expect(page).to have_content 'New Product Model'
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Peso'
    expect(page).to have_field 'Altura'
    expect(page).to have_field 'Largura'
    expect(page).to have_field 'Comprimento'
    expect(page).to have_field 'Fornecedor'
    expect(page).to have_field 'Categoria de Produto'
    expect(page).to have_button 'Save'
  end

  it 'successfully' do
    # Arrange
    create(:supplier, fantasy_name: "POP")
    create(:supplier, fantasy_name: "Souls Geek")
    create(:product_category, name: "Enlatados")
    create(:product_category, name: "Action Figure")
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Register new product model'
    fill_in 'Nome',	with: 'Estatua goku SSGSS'
    fill_in 'Peso',	with: '1500'
    fill_in 'Altura',	with: '150'
    fill_in 'Largura',	with: '45'
    fill_in 'Comprimento',	with: '45'
    select 'POP',	from: 'Fornecedor'
    select 'Action Figure', from: 'Categoria de Produto'
    click_on 'Save'

    # Assert
    pm = ProductModel.last
    expect(page).to have_content 'Successfully registered product model'
    expect(page).to have_content 'Estatua goku SSGSS'
    expect(page).to have_content 'Peso: 1500 gramas'
    expect(page).to have_content 'Dimensoes: 150 x 45 x 45'
    expect(page).to have_content "Codigo SKU: #{pm.sku}"
    expect(page).to have_content 'Fornecedor: POP'
    expect(page).to have_content 'Categoria de Produto: Action Figure'
  end

  it 'successfully with another supplier' do
    # Arrange
    create(:supplier, fantasy_name: "POP")
    create(:supplier, fantasy_name: "Souls Geek")
    create(:product_category, name: "Enlatados")
    create(:product_category, name: "Figure Action")
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Register new product model'
    fill_in 'Nome',	with: 'Estatua goku SSGSS'
    fill_in 'Peso',	with: '1500'
    fill_in 'Altura',	with: '150'
    fill_in 'Largura',	with: '45'
    fill_in 'Comprimento',	with: '45'
    select 'Souls Geek',	from: 'Fornecedor'
    select 'Figure Action', from: 'Categoria de Produto'
    click_on 'Save'

    # Assert
    pm = ProductModel.last
    expect(page).to have_content 'Successfully registered product model'
    expect(page).to have_content 'Estatua goku SSGSS'
    expect(page).to have_content 'Peso: 1500 gramas'
    expect(page).to have_content 'Dimensoes: 150 x 45 x 45'
    expect(page).to have_content "Codigo SKU: #{pm.sku}"
    expect(page).to have_content 'Fornecedor: Souls Geek'
    expect(page).to have_content 'Categoria de Produto: Figure Action'
  end

  it 'and all fields are required' do
    # Arrange
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Register new product model'
    fill_in 'Nome', with: ''
    fill_in 'Peso', with: ''
    fill_in 'Altura', with: ''
    fill_in 'Largura', with: ''
    fill_in 'Comprimento',	with: ''
    fill_in 'Comprimento',	with: ''
    click_on 'Save'

    # Assert
    expect(page).not_to have_content 'Successfully registered product model'
    expect(page).to have_content "It wasn't possible to record the product model"
    expect(page).to have_content 'Fornecedor é obrigatório(a)'
    expect(page).to have_content 'Categoria de Produto é obrigatório(a)'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Peso não pode ficar em branco'
    expect(page).to have_content 'Altura não pode ficar em branco'
    expect(page).to have_content 'Largura não pode ficar em branco'
    expect(page).to have_content 'Comprimento não pode ficar em branco'
  end

  it 'and neither weight nor dimensions can have values equal to or less than zero' do
    # Arrange
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Register new product model'
    fill_in 'Peso', with: '0'
    fill_in 'Altura', with: '0'
    fill_in 'Largura', with: '0'
    fill_in 'Comprimento',	with: '0'
    click_on 'Save'

    # Assert
    expect(page).to have_content 'Peso deve ser maior que 0'
    expect(page).to have_content 'Altura deve ser maior que 0'
    expect(page).to have_content 'Largura deve ser maior que 0'
    expect(page).to have_content 'Comprimento deve ser maior que 0'
  end
end
