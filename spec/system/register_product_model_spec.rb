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

  it 'successfully' do
    # Arrange
    Supplier.create!(fantasy_name: 'POP', legal_name: 'POP FUNKO', 
                     cnpj: '30605809000108', address: 'Av Fernandes Lima', 
                     email: 'pop@funko.com', phone: '91124-7753')
    Supplier.create!(fantasy_name: 'Souls Geek', legal_name: 'Souls Geek', 
                     cnpj: '64765467000105', address: 'Av Fernandes Lima', 
                     email: 'souls@geek.com', phone: '92854-8955')
    user = User.create!(email: 'joao@email.com', password: 'admino')
        
    # Act
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Register new product model'
    fill_in 'Nome',	with: 'Estatua goku SSGSS'
    fill_in 'Peso',	with: '1500'
    fill_in 'Altura',	with: '150'
    fill_in 'Largura',	with: '45'
    fill_in 'Comprimento',	with: '45'
    fill_in 'Codigo SKU',	with: 'CN203040ABC'
    select 'POP',	from: 'Fornecedor'
    click_on 'Register'

    # Assert
    expect(page).to have_content 'Successfully registered product model'
    expect(page).to have_content 'Estatua goku SSGSS'
    expect(page).to have_content 'Peso: 1500 gramas'
    expect(page).to have_content 'Dimensoes: 150 x 45 x 45'
    expect(page).to have_content 'Codigo SKU: CN203040ABC'
    expect(page).to have_content 'Fornecedor: POP'
  end

  it 'successfully with another supplier' do
    # Arrange
    Supplier.create!(fantasy_name: 'POP', legal_name: 'POP FUNKO', 
                     cnpj: '30605809000108', address: 'Av Fernandes Lima', 
                     email: 'pop@funko.com', phone: '91124-7753')
    Supplier.create!(fantasy_name: 'Souls Geek', legal_name: 'Souls Geek', 
                     cnpj: '64765467000105', address: 'Av Fernandes Lima', 
                     email: 'souls@geek.com', phone: '92854-8955')
    user = User.create!(email: 'joao@email.com', password: 'admino')
    
    # Act
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Register new product model'
    fill_in 'Nome',	with: 'Estatua goku SSGSS'
    fill_in 'Peso',	with: '1500'
    fill_in 'Altura',	with: '150'
    fill_in 'Largura',	with: '45'
    fill_in 'Comprimento',	with: '45'
    fill_in 'Codigo SKU',	with: 'CN203040ABC'
    select 'Souls Geek',	from: 'Fornecedor'
    click_on 'Register'

    # Assert
    expect(page).to have_content 'Successfully registered product model'
    expect(page).to have_content 'Estatua goku SSGSS'
    expect(page).to have_content 'Peso: 1500 gramas'
    expect(page).to have_content 'Dimensoes: 150 x 45 x 45'
    expect(page).to have_content 'Codigo SKU: CN203040ABC'
    expect(page).to have_content 'Fornecedor: Souls Geek'
  end

  it 'and all fields are required' do
    # Arrange
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Register new product model'
    fill_in 'Nome', with: ''
    fill_in 'Peso', with: ''
    fill_in 'Altura', with: ''
    fill_in 'Largura', with: ''
    fill_in 'Comprimento',	with: ''
    fill_in 'Codigo SKU',	with: ''
    click_on 'Register'

    # Assert
    expect(page).not_to have_content 'Successfully registered product model'
    expect(page).to have_content "It wasn't possible to record the product model"
    expect(page).to have_content 'Fornecedor é obrigatório(a)'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Peso não pode ficar em branco'
    expect(page).to have_content 'Altura não pode ficar em branco'
    expect(page).to have_content 'Largura não pode ficar em branco'
    expect(page).to have_content 'Comprimento não pode ficar em branco'
    expect(page).to have_content 'Codigo SKU não pode ficar em branco'   
  end

  it 'and neither weight nor dimensions can have values equal to or less than zero' do
    # Arrange
    user = User.create!(email: 'joao@email.com', password: 'admino')

    # Act
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Register new product model'
    fill_in 'Peso', with: '0'
    fill_in 'Altura', with: '0'
    fill_in 'Largura', with: '0'
    fill_in 'Comprimento',	with: '0'
    click_on 'Register'

    # Assert
    expect(page).to have_content 'Peso deve ser maior que 0'
    expect(page).to have_content 'Altura deve ser maior que 0'
    expect(page).to have_content 'Largura deve ser maior que 0'
    expect(page).to have_content 'Comprimento deve ser maior que 0'
  end
end
