require 'rails_helper'

RSpec.describe ProductItem, type: :model do
  it 'should generate an SKU with 20 characters' do
    # Arrange
    wh = Warehouse.create!(name: 'Juarez', code: 'JRZ', description: 'Otimo galpao numa linda cidade',
                           address: 'Av Fernandes Lima', city: 'Maceio', state: 'AL',
                           postal_code:'57050-000', total_area: 10000, useful_area: 8000)
    s = Supplier.create!(fantasy_name: 'Maria', legal_name: 'Maria e o pao',
                         cnpj: '59201134000113', address: 'Av Fernandes China',
                         email: 'maria.pao@yahoo.com', phone: '91124-7799')
    pc = ProductCategory.create!(name: 'Conservados')
    pm = ProductModel.create!(name: 'Doces', weight: 1100, height: 100, width: 100,
                              length: 100, supplier: s, product_category: pc)
    pi = ProductItem.new(warehouse: wh, product_model: pm)

    # Act
    pi.save()

    # Assert
    expect(pi.sku).not_to eq nil
    expect(pi.sku.length).to eq 20
  end

  it 'should generate a random SKU' do
    # Arrange
    wh = Warehouse.create!(name: 'Juarez', code: 'JRZ', description: 'Otimo galpao numa linda cidade',
                           address: 'Av Fernandes Lima', city: 'Maceio', state: 'AL',
                           postal_code:'57050-000', total_area: 10000, useful_area: 8000)
    s = Supplier.create!(fantasy_name: 'Maria', legal_name: 'Maria e o pao',
                         cnpj: '59201134000113', address: 'Av Fernandes China',
                         email: 'maria.pao@yahoo.com', phone: '91124-7799')
    pc = ProductCategory.create!(name: 'Conservados')
    pm = ProductModel.create!(name: 'Doces', weight: 1100, height: 100, width: 100,
                              length: 100, supplier: s, product_category: pc)
    pi = ProductItem.new(warehouse: wh, product_model: pm)
    allow(SecureRandom).to receive(:alphanumeric).with(17).and_return 'XjDED8ylT4hFzqVnl'

    # Act
    pi.save()
    
    # Assert
    expect(pi.sku).to eq 'SKUXjDED8ylT4hFzqVnl'
  end

  it 'should generate unique SKU' do
    # Arrange
    wh = Warehouse.create!(name: 'Juarez', code: 'JRZ', description: 'Otimo galpao numa linda cidade',
                           address: 'Av Fernandes Lima', city: 'Maceio', state: 'AL',
                           postal_code:'57050-000', total_area: 10000, useful_area: 8000)
    s = Supplier.create!(fantasy_name: 'Maria', legal_name: 'Maria e o pao',
                         cnpj: '59201134000113', address: 'Av Fernandes China',
                         email: 'maria.pao@yahoo.com', phone: '91124-7799')
    pc = ProductCategory.create!(name: 'Conservados')
    pm = ProductModel.create!(name: 'Doces', weight: 1100, height: 100, width: 100,
                              length: 100, supplier: s, product_category: pc)
    pi1 = ProductItem.create!(warehouse: wh, product_model: pm)
    pi2 = ProductItem.new(warehouse: wh, product_model: pm)
    sku = pi1.sku
    allow(SecureRandom).to receive(:alphanumeric).with(17).and_return sku
    pi2.save()

    # Act
    result = pi2.valid?

    # Assert
    expect(result).to eq false
  end

  it 'should not be valid if the sku is empty' do
    # Arrange
    wh = Warehouse.create!(name: 'Juarez', code: 'JRZ', description: 'Otimo galpao numa linda cidade',
                           address: 'Av Fernandes Lima', city: 'Maceio', state: 'AL',
                           postal_code:'57050-000', total_area: 10000, useful_area: 8000)
    s = Supplier.create!(fantasy_name: 'Maria', legal_name: 'Maria e o pao',
                         cnpj: '59201134000113', address: 'Av Fernandes China',
                         email: 'maria.pao@yahoo.com', phone: '91124-7799')
    pc = ProductCategory.create!(name: 'Conservados')
    pm = ProductModel.create!(name: 'Doces', weight: 1100, height: 100, width: 100,
                              length: 100, supplier: s, product_category: pc)
    pi = ProductItem.new(warehouse: wh, product_model: pm)
    allow(SecureRandom).to receive(:alphanumeric).with(17).and_return ''

    # Act
    result = pi.valid?

    # Assert
    expect(result).to eq false    
  end

  context 'should not be valid if sku is in wrong format' do
    it 'SKUa4s582d4f536f4g7h4ytr' do
      # Arrange
      wh = Warehouse.create!(name: 'Juarez', code: 'JRZ', description: 'Otimo galpao numa linda cidade',
                             address: 'Av Fernandes Lima', city: 'Maceio', state: 'AL',
                             postal_code:'57050-000', total_area: 10000, useful_area: 8000)
      s = Supplier.create!(fantasy_name: 'Maria', legal_name: 'Maria e o pao',
                           cnpj: '59201134000113', address: 'Av Fernandes China',
                           email: 'maria.pao@yahoo.com', phone: '91124-7799')
      pc = ProductCategory.create!(name: 'Conservados')
      pm = ProductModel.create!(name: 'Doces', weight: 1100, height: 100, width: 100,
                                length: 100, supplier: s, product_category: pc)
      pi = ProductItem.new(warehouse: wh, product_model: pm)
      allow(SecureRandom).to receive(:alphanumeric).with(17).and_return 'SKUa4s582d4f536f4g7h4ytr'

      # Act
      result = pi.valid?
    
      # Assert
      expect(result).to eq false
    end

    it 'SKUa4s582d4f536f4g7h4' do
      # Arrange
      wh = Warehouse.create!(name: 'Juarez', code: 'JRZ', description: 'Otimo galpao numa linda cidade',
                             address: 'Av Fernandes Lima', city: 'Maceio', state: 'AL',
                             postal_code:'57050-000', total_area: 10000, useful_area: 8000)
      s = Supplier.create!(fantasy_name: 'Maria', legal_name: 'Maria e o pao',
                           cnpj: '59201134000113', address: 'Av Fernandes China',
                           email: 'maria.pao@yahoo.com', phone: '91124-7799')
      pc = ProductCategory.create!(name: 'Conservados')
      pm = ProductModel.create!(name: 'Doces', weight: 1100, height: 100, width: 100,
                                length: 100, supplier: s, product_category: pc)
      pi = ProductItem.new(warehouse: wh, product_model: pm)
      allow(SecureRandom).to receive(:alphanumeric).with(17).and_return 'SKUa4s582d4f536f4g7h4'

      # Act
      result = pi.valid?
    
      # Assert
      expect(result).to eq false
    end
  end
end
