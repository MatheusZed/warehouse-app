require 'rails_helper'

describe 'Visitor sees the product category' do
  it 'and sees all registered data' do
    # Arrange
    s = Supplier.create!(
      fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
      cnpj: '30605809000108', address: 'Av Fernandes Lima',
      email: 'joao.feijao@yahoo.com', phone: '91124-7753')
    pc = ProductCategory.create!(
      name: 'Conservados'
    )
    pm = ProductModel.create!(
      name: 'Saco de Feijao', weight: 1000, height: 4, width: 17,
      length: 22, supplier: s, product_category: pc
    )

    # Act
    visit root_path
    click_on 'See product categories'
    click_on 'Conservados'

    # Assert
    expect(page).to have_css 'h1', text: 'Conservados'
    expect(page).to have_content 'Joao'
    expect(page).to have_content 'Saco de Feijao'
    expect(page).to have_content pm.sku
  end

  it 'and can return to product categories page' do
    # Arrange
    s = Supplier.create!(
      fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
      cnpj: '30605809000108', address: 'Av Fernandes Lima',
      email: 'joao.feijao@yahoo.com', phone: '91124-7753'
    )
    pc = ProductCategory.create!(
      name: 'Conservados'
    )
    ProductModel.create!(
      name: 'Saco de Feijao', weight: 1000, height: 4, width: 17,
      length: 22, supplier: s, product_category: pc
    )

    # Act
    visit root_path
    click_on 'See product categories'
    click_on 'Conservados'
    click_on 'Return'

    # Assert
    expect(current_path).to eq product_categories_path
  end
end
