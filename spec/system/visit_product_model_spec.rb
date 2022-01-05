require 'rails_helper'

describe 'Visitor sees the product model' do
  it 'and sees all registered data' do
    # Arrange
    s = Supplier.create!(fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
                         cnpj: '30605809000108', address: 'Av Fernandes Lima',
                         email: 'joao.feijao@yahoo.com', phone: '91124-7753')
    ProductModel.create!(name: 'Saco de Feijao', weight: 1000, height: 4,
                         width: 17, length: 22, supplier: s, sku: 'I12A')

    # Act
    visit root_path
    click_on 'See suppliers'
    click_on 'Joao'
    click_on 'Saco de Feijao'

    # Assert
    expect(page).to have_css 'h1', text: 'Saco de Feijao'
    expect(page).to have_content 'Saco de Feijao'
    expect(page).to have_content 'Peso: 1000'
    expect(page).to have_content 'Dimensoes: 4 x 17 x 22'
    expect(page).to have_content 'SKU: I12A'    
    expect(page).to have_content 'Fornecedor: Joao'
  end

  it 'and can return to supplier page' do
    # Arrange
    s = Supplier.create!(fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
                         cnpj: '30605809000108', address: 'Av Fernandes Lima',
                         email: 'joao.feijao@yahoo.com', phone: '91124-7753')
    ProductModel.create!(name: 'Saco de Feijao', weight: 1000, height: 4,
                         width: 17, length: 22, supplier: s, sku: 'I12A')

    # Act
    visit root_path
    click_on 'See suppliers'
    click_on 'Joao'
    click_on 'Saco de Feijao'
    click_on 'Return'

    # Assert
    expect(current_path).to eq supplier_path(s.id)
  end
end
