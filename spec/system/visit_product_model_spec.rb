require 'rails_helper'

describe 'Visitor sees the product model' do
  it 'and sees all registered data' do
    # Arrange
    s = Supplier.create!(
      fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
      cnpj: '30605809000108', address: 'Av Fernandes Lima',
      email: 'joao.feijao@yahoo.com', phone: '91124-7753'
    )
    pc = ProductCategory.create!(
      name: 'Conservados'
    )
    pm = ProductModel.create!(
      name: 'Saco de Feijao', weight: 1000, height: 4, width: 17,
      length: 22, supplier: s, product_category: pc
    )

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
    expect(page).to have_content pm.sku
    expect(page).to have_content 'Fornecedor: Joao'
  end

  it 'and can return to supplier page' do
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
    click_on 'See suppliers'
    click_on 'Joao'
    click_on 'Saco de Feijao'
    click_on 'Return'

    # Assert
    expect(current_path).to eq supplier_path(s.id)
  end

  it 'and sees the available warehouses' do
    # Arrange
    pc = ProductCategory.create!(
      name: 'Conservados'
    )
    wh1 = Warehouse.create!(
      name: 'Juarez', code: 'JRZ', description: 'Otimo galpao numa linda cidade com luzes',
      address: 'Av Fernandes Lima', city: 'Maceio', state: 'AL', postal_code:'57050-000',
      total_area: 10000, useful_area: 8000, product_category_ids: [pc.id]
    )
    wh2 = Warehouse.create!(
      name: 'Plancton', code: 'PLN', description: 'Otimo galpao numa linda cidade com luzes',
      address: 'Av Fernandes Lima', city: 'Maceio', state: 'AL', postal_code:'57011-000',
      total_area: 10000, useful_area: 8000, product_category_ids: [pc.id]
    )
    s = Supplier.create!(
      fantasy_name: 'Maria', legal_name: 'Maria e o pao',
      cnpj: '59201134000113', address: 'Av Fernandes China',
      email: 'maria.pao@yahoo.com', phone: '91124-7799'
    )
    pm1 = ProductModel.create!(
      name: 'Migalhas de pao', weight: 1000, height: 4, width: 17,
      length: 22, supplier: s, product_category: pc
    )
    pm2 = ProductModel.create!(
      name: 'Osso de Frango', weight: 5, height: 15, width: 2,
      length: 2, supplier: s, product_category: pc
    )
    pm3 = ProductModel.create!(
      name: 'Doces', weight: 1100, height: 100, width: 100,
      length: 100, supplier: s, product_category: pc
    )
    ProductItem.create!(warehouse: wh1, product_model: pm3)
    ProductItem.create!(warehouse: wh1, product_model: pm3)
    ProductItem.create!(warehouse: wh1, product_model: pm3)
    ProductItem.create!(warehouse: wh1, product_model: pm3)
    ProductItem.create!(warehouse: wh1, product_model: pm3)
    ProductItem.create!(warehouse: wh2, product_model: pm3)
    ProductItem.create!(warehouse: wh2, product_model: pm3)
    ProductItem.create!(warehouse: wh2, product_model: pm3)
    ProductItem.create!(warehouse: wh2, product_model: pm3)

    # Act
    visit root_path
    click_on 'See suppliers'
    click_on 'Maria'
    click_on 'Doces'

    # Assert
    expect(page).to have_content 'Available Warehouses'
    expect(page).to have_content 'Codigo do Galpao Quantidade'
    within("div#warehouse-#{wh1.id}") do
      expect(page).to have_content 'JRZ 5'
    end
    within("div#warehouse-#{wh2.id}") do
      expect(page).to have_content 'PLN 4'
    end
  end
end
