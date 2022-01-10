require 'rails_helper'

describe 'Visitor sees the product model' do
  it 'and sees all registered data' do
    # Arrange
    s = Supplier.create!(fantasy_name: 'Maria', legal_name: 'Maria e os doces',
                         cnpj: '22416076000136', address: 'Rua Benedito Spinardi',
                         email: 'maria.doceria@yahoo.com', phone: '91124-2855')
    pc = ProductCategory.create!(name: 'Conservados')
    pm1 = ProductModel.create!(name: 'Migalhas de pao', weight: 1000, height: 4, width: 17,
                               length: 22, supplier: s, product_category: pc)
    pm2 = ProductModel.create!(name: 'Osso de Frango', weight: 1000, height: 4, width: 17,
                               length: 22, supplier: s, product_category: pc)
    pm3 = ProductModel.create!(name: 'Doces', weight: 1000, height: 4, width: 17,
                               length: 22, supplier: s, product_category: pc)
    pb1 = ProductBundle.create!(name: 'Kit Bruxaria')
    pb2 = ProductBundle.create!(name: 'Kit Xariabru')
    ProductBundleItem.create!(product_bundle: pb1, product_model: pm1)
    ProductBundleItem.create!(product_bundle: pb1, product_model: pm2)
    ProductBundleItem.create!(product_bundle: pb1, product_model: pm3)
    ProductBundleItem.create!(product_bundle: pb2, product_model: pm1)
    ProductBundleItem.create!(product_bundle: pb2, product_model: pm3)

    # Act
    visit root_path
    click_on 'See suppliers'
    click_on 'Maria'
    click_on 'Kit Bruxaria'

    # Assert
    expect(page).to have_css 'h1', text: 'Kit Bruxaria'
    expect(page).to have_content "Codigo SKU: #{pb1.sku}"
    expect(page).to have_content 'Migalhas de pao'
    expect(page).to have_content 'Osso de Frango'
    expect(page).to have_content 'Doces'
  end

  it 'and can return to supplier page' do
    # Arrange
    s = Supplier.create!(fantasy_name: 'Maria', legal_name: 'Maria e os doces',
                         cnpj: '22416076000136', address: 'Rua Benedito Spinardi',
                         email: 'maria.doceria@yahoo.com', phone: '91124-2855')
    pc = ProductCategory.create!(name: 'Conservados')
    pm1 = ProductModel.create!(name: 'Migalhas de pao', weight: 1000, height: 4, width: 17,
                               length: 22, supplier: s, product_category: pc)
    pm2 = ProductModel.create!(name: 'Osso de Frango', weight: 1000, height: 4, width: 17,
                               length: 22, supplier: s, product_category: pc)
    pm3 = ProductModel.create!(name: 'Doces', weight: 1000, height: 4, width: 17,
                               length: 22, supplier: s, product_category: pc)
    pb1 = ProductBundle.create!(name: 'Kit Bruxaria')
    pb2 = ProductBundle.create!(name: 'Kit Xariabru')
    ProductBundleItem.create!(product_bundle: pb1, product_model: pm1)
    ProductBundleItem.create!(product_bundle: pb1, product_model: pm2)
    ProductBundleItem.create!(product_bundle: pb1, product_model: pm3)
    ProductBundleItem.create!(product_bundle: pb2, product_model: pm1)
    ProductBundleItem.create!(product_bundle: pb2, product_model: pm3)

    # Act
    visit root_path
    click_on 'See suppliers'
    click_on 'Maria'
    click_on 'Kit Xariabru'
    click_on 'Return'

    # Assert
    expect(current_path).to eq supplier_path(s.id)
  end
end
