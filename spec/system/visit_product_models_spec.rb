require 'rails_helper'

describe 'Visitor see product models' do
  it 'and sees the resgistered product models' do
    # Arrange
    s = Supplier.create!(fantasy_name: 'Maria', legal_name: 'Maria e o pao',
                         cnpj: '59201134000113', address: 'Av Fernandes China',
                         email: 'maria.pao@yahoo.com', phone: '91124-7799')
    pc = ProductCategory.create!(name: 'Conservados')
    pm1 = ProductModel.create!(name: 'Migalhas de pao', weight: 1000, height: 4, width: 17,
                               length: 22, supplier: s, product_category: pc)
    pm2 = ProductModel.create!(name: 'Osso de Frango', weight: 5, height: 15, width: 2,
                               length: 2, supplier: s, product_category: pc)
    pm3 = ProductModel.create!(name: 'Doces', weight: 1100, height: 100, width: 100,
                               length: 100, supplier: s, product_category: pc)

    # Act
    visit root_path
    click_on 'See suppliers'
    click_on 'Maria'

    # Assert
    expect(page).to have_css '#pm h2', text: 'Product models from this supplier'
    expect(page).to have_css '#pmi', text: 'Migalhas de pao'
    expect(page).to have_css '#pmi', text: pm1.sku
    expect(page).to have_css '#pmi', text: 'Osso de Frango'
    expect(page).to have_css '#pmi', text: pm2.sku
    expect(page).to have_css '#pmi', text: 'Doces'
    expect(page).to have_css '#pmi', text: pm3.sku
  end

  it "and don't sees the product models details" do
    # Arrange
    s = Supplier.create!(fantasy_name: 'Maria', legal_name: 'Maria e o pao',
                         cnpj: '59201134000113', address: 'Av Fernandes China',
                         email: 'maria.pao@yahoo.com', phone: '91124-7799')
    pc = ProductCategory.create!(name: 'Conservados')
    ProductModel.create!(name: 'Migalhas de pao', weight: 1000, height: 10, width: 5,
                         length: 22, supplier: s, product_category: pc)
    ProductModel.create!(name: 'Osso de Frango', weight: 5, height: 15, width: 2,
                         length: 2, supplier: s, product_category: pc)
    ProductModel.create!(name: 'Doces', weight: 1100, height: 100, width: 100,
                         length: 100, supplier: s, product_category: pc)

    # Act
    visit root_path
    click_on 'See suppliers'
    click_on 'Maria'

    # Assert
    expect(page).not_to have_css '#pm dd', text: 'Maria'
    expect(page).not_to have_css '#pmi', text: 'Peso: 1000'
    expect(page).not_to have_css '#pmi', text: 'Dimensoes: 10 x 5 x 22'
    expect(page).not_to have_css '#pmi', text: 'Peso: 5'
    expect(page).not_to have_css '#pmi', text: 'Dimensoes: 15 x 2 x 2'
    expect(page).not_to have_css '#pmi', text: 'Peso: 1100'
    expect(page).not_to have_css '#pmi', text: 'Dimensoes: 100 x 100 x 100'
  end

  it "and don't sees other supplier product models" do
    # Arrange
    s1 = Supplier.create!(fantasy_name: 'Maria', legal_name: 'Maria e o pao',
                          cnpj: '59201134000113', address: 'Av Fernandes China',
                          email: 'maria.pao@yahoo.com', phone: '91124-7799')
    s2 = Supplier.create!(fantasy_name: 'Joao', legal_name: 'Joao e a bruxa',
                          cnpj: '59201134000114', address: 'Av Fernandes Bruxas',
                          email: 'joao.bruxa@yahoo.com', phone: '91124-7199')
    pc = ProductCategory.create!(name: 'Conservados')
    pm1 = ProductModel.create!(name: 'Migalhas de pao', weight: 1000, height: 10, width: 5,
                               length: 22, supplier: s1, product_category: pc)
    pm2 = ProductModel.create!(name: 'Osso de Frango', weight: 5, height: 15, width: 2,
                               length: 2, supplier: s1, product_category: pc)
    pm3 = ProductModel.create!(name: 'Doces', weight: 1100, height: 100, width: 100,
                               length: 100, supplier: s2, product_category: pc)
    pm4 = ProductModel.create!(name: 'Casinha de Doces', weight: 5000, height: 1000, width: 1000,
                               length: 1000, supplier: s2, product_category: pc)

    # Act
    visit root_path
    click_on 'See suppliers'
    click_on 'Joao'

    # Assert
    expect(page).to have_css '#pmi', text: 'Doces'
    expect(page).to have_css '#pmi', text: pm3.sku
    expect(page).to have_css '#pmi', text: 'Casinha de Doces'
    expect(page).to have_css '#pmi', text: pm4.sku
    expect(page).not_to have_css '#pmi', text: 'Migalhas de pao'
    expect(page).not_to have_css '#pmi', text: pm1.sku
    expect(page).not_to have_css '#pmi', text: 'Osso de Frango'
    expect(page).not_to have_css '#pmi', text: pm2.sku
  end

  it "and doesn't exist any product model" do
    # Arrange
    Supplier.create!(fantasy_name: 'Maria', legal_name: 'Maria e o pao',
                     cnpj: '59201134000113', address: 'Av Fernandes China',
                     email: 'maria.pao@yahoo.com', phone: '91124-7799')

    # Act
    visit root_path
    click_on 'See suppliers'
    click_on 'Maria'

    # Assert
    expect(page).to have_css '#pm', text: 'No registered product model'
  end
end
