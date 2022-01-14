require 'rails_helper'

describe 'Visitor see product bundles' do
  it 'and sees the resgistered product bundles' do
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
    ProductBundleItem.create!(product_bundle: pb2, product_model: pm1)
    ProductBundleItem.create!(product_bundle: pb2, product_model: pm3)

    # Act
    visit root_path
    click_on 'See suppliers'
    click_on 'Maria'

    # Assert
    expect(page).to have_css '#pb h2', text: 'Bundles from this supplier'
    expect(page).to have_css '#pbi', text: 'Kit Bruxaria'
    expect(page).to have_css '#pbi', text: pb1.sku
    expect(page).to have_css '#pbi', text: 'Kit Xariabru'
    expect(page).to have_css '#pbi', text: pb2.sku
  end

  it "and don't sees the product bundles details" do
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

    # Assert
    expect(page).not_to have_css '#pb td', text: 'Maria'
    expect(page).not_to have_css '#pbi', text: 'Migalhas de pao'
    expect(page).not_to have_css '#pbi', text: 'Osso de Frango'
    expect(page).not_to have_css '#pbi', text: 'Doces'
  end

  it "and don't sees other supplier product bundles" do
    # Arrange
    s1 = Supplier.create!(fantasy_name: 'Maria', legal_name: 'Maria e os doces',
                          cnpj: '22416076000136', address: 'Rua Benedito Spinardi',
                          email: 'maria.doceria@yahoo.com', phone: '91124-2855')
    s2 = Supplier.create!(fantasy_name: 'Joao', legal_name: 'Joao e a bruxa',
                          cnpj: '59201134000114', address: 'Av Fernandes Bruxas',
                          email: 'joao.bruxa@yahoo.com', phone: '91124-7199')
    pc = ProductCategory.create!(name: 'Conservados')
    pm1 = ProductModel.create!(name: 'Migalhas de pao', weight: 1000, height: 10, width: 5,
                               length: 22, supplier: s1, product_category: pc)
    pm2 = ProductModel.create!(name: 'Osso de Frang0', weight: 5, height: 15, width: 2,
                               length: 2, supplier: s1, product_category: pc)
    pm3 = ProductModel.create!(name: 'Caldeirao', weight: 10000, height: 2000, width: 2000,
                               length: 2000, supplier: s1, product_category: pc)
    pm4 = ProductModel.create!(name: 'Doces', weight: 1100, height: 100,  width: 100,
                               length: 100, supplier: s2, product_category: pc)
    pm5 = ProductModel.create!(name: 'Casinha de Doces', weight: 5000, height: 1000, width: 1000,
                               length: 1000, supplier: s2, product_category: pc)
    pm6 = ProductModel.create!(name: 'Gaiola', weight: 4000, height: 1000, width: 1000,
                               length: 1000, supplier: s2, product_category: pc)
    pb1 = ProductBundle.create!(name: 'Kit Bruxaria')
    pb2 = ProductBundle.create!(name: 'Kit Xariabru')
    pb3 = ProductBundle.create!(name: 'Kit Xabruria')
    pb4 = ProductBundle.create!(name: 'Kit Riabruxa')
    ProductBundleItem.create!(product_bundle: pb1, product_model: pm1)
    ProductBundleItem.create!(product_bundle: pb1, product_model: pm2)
    ProductBundleItem.create!(product_bundle: pb2, product_model: pm1)
    ProductBundleItem.create!(product_bundle: pb2, product_model: pm3)
    ProductBundleItem.create!(product_bundle: pb3, product_model: pm4)
    ProductBundleItem.create!(product_bundle: pb3, product_model: pm5)
    ProductBundleItem.create!(product_bundle: pb4, product_model: pm4)
    ProductBundleItem.create!(product_bundle: pb4, product_model: pm6)
    
    # Act
    visit root_path
    click_on 'See suppliers'
    click_on 'Joao'

    # Assert
    expect(page).to have_css '#pbi', text: 'Xabruria'
    expect(page).to have_css '#pbi', text: pb3.sku
    expect(page).to have_css '#pbi', text: 'Riabruxa'
    expect(page).to have_css '#pbi', text: pb4.sku
    expect(page).not_to have_css '#pbi', text: 'Bruxaria'
    expect(page).not_to have_css '#pbi', text: pb1.sku
    expect(page).not_to have_css '#pbi', text: 'Xariabru'
    expect(page).not_to have_css '#pbi', text: pb2.sku
  end

  it "and doesn't exist any product bundle" do
    # Arrange
    Supplier.create!(fantasy_name: 'Maria', legal_name: 'Maria e o pao',
                     cnpj: '59201134000113', address: 'Av Fernandes China',
                     email: 'maria.pao@yahoo.com', phone: '91124-7799')

    # Act
    visit root_path
    click_on 'See suppliers'
    click_on 'Maria'

    # Assert
    expect(page).to have_css '#pb', text: 'No registered product bundle'
  end
end
