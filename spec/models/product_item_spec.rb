require 'rails_helper'

RSpec.describe ProductItem, type: :model do
  let(:supplier) { create(:supplier) }
  let(:pc) { create(:product_category) }
  let(:warehouse) { create(:warehouse, product_category_ids: [pc.id]) }
  let(:pm) { create(:product_model, supplier: supplier, product_category: pc) }

  it 'should generate an SKU with 20 characters' do
    # Arrange
    pi = build(:product_item, warehouse: warehouse, product_model: pm)

    # Act
    pi.save

    # Assert
    expect(pi.sku).not_to eq nil
    expect(pi.sku.length).to eq 20
  end

  it 'should generate a random SKU' do
    # Arrange
    pi = build(:product_item, warehouse: warehouse, product_model: pm)
    allow(SecureRandom).to receive(:alphanumeric).with(17).and_return 'XjDED8ylT4hFzqVnl'

    # Act
    pi.save

    # Assert
    expect(pi.sku).to eq 'SKUXjDED8ylT4hFzqVnl'
  end

  it 'should generate unique SKU' do
    # Arrange
    pi1 = create(:product_item, warehouse: warehouse, product_model: pm)
    pi2 = build(:product_item, warehouse: warehouse, product_model: pm)
    sku = pi1.sku
    allow(SecureRandom).to receive(:alphanumeric).with(17).and_return sku
    pi2.save

    # Act
    result = pi2.valid?

    # Assert
    expect(result).to eq false
  end

  it 'should not be valid if the sku is empty' do
    # Arrange
    pi = build(:product_item, warehouse: warehouse, product_model: pm)
    allow(SecureRandom).to receive(:alphanumeric).with(17).and_return ''

    # Act
    result = pi.valid?

    # Assert
    expect(result).to eq false
  end

  context 'should not be valid if sku is in wrong format' do
    it 'SKUa4s582d4f536f4g7h4ytr' do
      # Arrange
      pi = build(:product_item, warehouse: warehouse, product_model: pm)
      allow(SecureRandom).to receive(:alphanumeric).with(17).and_return 'SKUa4s582d4f536f4g7h4ytr'

      # Act
      result = pi.valid?

      # Assert
      expect(result).to eq false
    end

    it 'SKUa4s582d4f536f4g7h4' do
      # Arrange
      pi = build(:product_item, warehouse: warehouse, product_model: pm)
      allow(SecureRandom).to receive(:alphanumeric).with(17).and_return 'SKUa4s582d4f536f4g7h4'

      # Act
      result = pi.valid?

      # Assert
      expect(result).to eq false
    end
  end

  it 'should not update SKU' do
    # Arrange
    pm2 = create(:product_model, supplier: supplier, product_category: pc)
    pi = create(:product_item, warehouse: warehouse, product_model: pm)
    sku = pi.sku

    # Act
    pi.update(warehouse: warehouse, product_model: pm2)

    # Assert
    expect(pi.sku).to eq sku
  end
end
