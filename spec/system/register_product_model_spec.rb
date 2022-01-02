require 'rails_helper'

describe 'User register product model' do
  it 'successfully' do
    # Arrange
    Supplier.create(fantasy_name: 'POP', legal_name: 'POP FUNKO', 
                    cnpj: '30605809000108', address: 'Av Fernandes Lima', 
                    email: 'pop@funko.com', phone: '91124-7753')
    Supplier.create(fantasy_name: 'Souls Geek', legal_name: 'Souls Geek', 
                    cnpj: '64765467000105', address: 'Av Fernandes Lima', 
                    email: 'souls@geek.com', phone: '92854-8955')
    
    # Act
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

  it '' do
    
  end
end
