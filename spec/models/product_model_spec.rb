require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  let(:supplier) { create(:supplier) }
  let(:pc) { create(:product_category) }

  it '.dimension' do
    # Arrange
    p = build(
      :product_model, height: '14', width: '10', length: '12',
      supplier: supplier, product_category: pc
    )

    # Act
    result = p.dimensions

    # Assert
    expect(result).to eq '14 x 10 x 12'
  end

  context 'should not be valid if the fields are empty' do
    it 'name' do
      # Arrange
      pm = build(:product_model, name: '', supplier: supplier, product_category: pc)

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end

    it 'weight' do
      # Arrange
      pm = build(:product_model, weight: '', supplier: supplier, product_category: pc)

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end

    it 'height' do
      # Arrange
      pm = build(:product_model, height: '', supplier: supplier, product_category: pc)

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end

    it 'width' do
      # Arrange
      pm = build(:product_model, width: '', supplier: supplier, product_category: pc)

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end

    it 'length' do
      # Arrange
      pm = build(:product_model, length: '', supplier: supplier, product_category: pc)

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end

    it 'supplier' do
      # Arrange
      pm = build(:product_model, supplier_id: '', product_category: pc)

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end

    it 'product category' do
      # Arrange
      pm = build(:product_model, supplier: supplier, product_category_id: '')

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end

    it 'sku' do
      # Arrange
      pm = build(:product_model, supplier: supplier, product_category: pc)
      allow(SecureRandom).to receive(:alphanumeric).with(17).and_return ''

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end
  end

  context 'must not be valid if the fields are less than one' do
    it 'weight' do
      # Arrange
      pm = build(:product_model, weight: 0, supplier: supplier, product_category: pc)

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end

    it 'height' do
      # Arrange
      pm = build(:product_model, height: 0, supplier: supplier, product_category: pc)

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end

    it 'width' do
      # Arrange
      pm = build(:product_model, width: 0, supplier: supplier, product_category: pc)

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end

    it 'length' do
      # Arrange
      pm = build(:product_model, length: 0, supplier: supplier, product_category: pc)

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end
  end

  it 'should generate an SKU with 20 characters' do
    # Arrange
    pm = build(:product_model, supplier: supplier, product_category: pc)

    # Act
    pm.save

    # Assert
    expect(pm.sku).not_to eq nil
    expect(pm.sku.length).to eq 20
  end

  it 'should generate a random SKU' do
    # Arrange
    pm = build(:product_model, supplier: supplier, product_category: pc)
    allow(SecureRandom).to receive(:alphanumeric).with(17).and_return 'XjDED8ylT4hFzqVnl'

    # Act
    pm.save

    # Assert
    expect(pm.sku).to eq 'SKUXjDED8ylT4hFzqVnl'
  end

  it 'should generate unique SKU' do
    # Arrange
    pm1 = create(:product_model, supplier: supplier, product_category: pc)
    pm2 = build(:product_model, supplier: supplier, product_category: pc)
    sku = pm1.sku
    allow(SecureRandom).to receive(:alphanumeric).with(17).and_return sku
    pm2.save

    # Act
    result = pm2.valid?

    # Assert
    expect(result).to eq false
  end

  it 'should not update SKU' do
    # Arrange
    pm = create(:product_model, supplier: supplier, product_category: pc)
    sku = pm.sku

    # Act
    pm.update(name: 'Funcionou')

    # Assert
    expect(pm.name).to eq 'Funcionou'
    expect(pm.sku).to eq sku
  end

  context 'should not be valid if sku is in wrong format' do
    it 'SKUa4s582d4f536f4g7h4ytr' do
      # Arrange
      pm = build(:product_model, supplier: supplier, product_category: pc)
      allow(SecureRandom).to receive(:alphanumeric).with(17).and_return 'SKUa4s582d4f536f4g7h4ytr'

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end

    it 'SKUa4s582d4f536f4g7h4' do
      # Arrange
      pm = build(:product_model, supplier: supplier, product_category: pc)
      allow(SecureRandom).to receive(:alphanumeric).with(17).and_return 'SKUa4s582d4f536f4g7h4'

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end
  end
end
