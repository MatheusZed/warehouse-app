require 'rails_helper'

RSpec.describe ProductBundle, type: :model do
  let(:supplier) { create(:supplier) }
  let(:pc) { create(:product_category) }
  let(:pm1) { create(:product_model, supplier: supplier, product_category: pc) }
  let(:pm2) { create(:product_model, supplier: supplier, product_category: pc) }

  context 'should not be valid if the fields are empty' do
    it 'name' do
      # Arrage
      pb = build(:product_bundle, name: '', product_model_ids: [pm1.id, pm2.id])

      # Act
      result = pb.valid?

      # Assert
      expect(result).to eq false
    end

    it 'sku' do
      # Arrage
      pb = build(:product_bundle, product_model_ids: [pm1.id, pm2.id])
      allow(SecureRandom).to receive(:alphanumeric).with(17).and_return ''

      # Act
      result = pb.valid?

      # Assert
      expect(result).to eq false
    end
  end

  context 'should not be valid if the fields are duplicate' do
    it 'name' do
      # Arrage
      create(:product_bundle, name: 'Kit Vinho', product_model_ids: [pm1.id, pm2.id])
      pb = build(:product_bundle, name: 'Kit Vinho', product_model_ids: [pm1.id, pm2.id])

      # Act
      result = pb.valid?

      # Assert
      expect(result).to eq false
    end

    it 'sku' do
      # Arrange
      pb1 = create(:product_bundle, name: 'Kit Vinho', product_model_ids: [pm1.id, pm2.id])
      pb2 = build(:product_bundle, name: 'Kit Vinho Gurme', product_model_ids: [pm1.id, pm2.id])
      sku = pb1.sku
      allow(SecureRandom).to receive(:alphanumeric).with(17).and_return sku
      pb2.save

      # Act
      result = pb2.valid?

      # Assert
      expect(result).to eq false
    end
  end

  it 'should generate an SKU with 21 characters' do
    # Arrange
    pb = build(:product_bundle, product_model_ids: [pm1.id, pm2.id])

    # Act
    pb.save

    # Assert
    expect(pb.sku).not_to eq nil
    expect(pb.sku.length).to eq 21
  end

  it 'should generate a random SKU' do
    # Arrange
    pb = build(:product_bundle, product_model_ids: [pm1.id, pm2.id])

    # Act
    pb.save

    # Assert
    expect(pb.sku).to be_present
    expect(pb.sku.size).to eq(21)
  end

  context 'should not be valid if sku is in wrong format' do
    it 'KSKUa4s582d4f536f4g7h4ytr' do
      # Arrange
      pb = create(:product_bundle, product_model_ids: [pm1.id, pm2.id])
      pb.update(sku: 'KSKUa4s582d4f536f4g7h4ytr')

      # Act
      result = pb.valid?

      # Assert
      expect(result).to eq false
    end

    it 'SKUa4s582d4f536f4g7h4' do
      # Arrange
      pb = create(:product_bundle, product_model_ids: [pm1.id, pm2.id])
      pb.update(sku: 'KSKUa4s582d4f536f4g7h4ytr')

      # Act
      result = pb.valid?

      # Assert
      expect(result).to eq false
    end
  end

  it 'should not update SKU' do
    # Arrange
    pb = create(:product_bundle, product_model_ids: [pm1.id, pm2.id])
    sku = pb.sku

    # Act
    pb.update(name: 'Kit Vinheto')

    # Assert
    expect(pb.name).to eq 'Kit Vinheto'
    expect(pb.sku).to eq sku
  end
end
