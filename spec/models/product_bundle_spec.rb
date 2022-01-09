require 'rails_helper'

RSpec.describe ProductBundle, type: :model do
  context 'should not be valid if the fields are empty' do
    it 'name' do
      # Arrage
      pb = ProductBundle.new(name: '')

      # Act
      result = pb.valid?

      # Assert
      expect(result).to eq false
    end

    it 'sku' do
      # Arrage
      pb = ProductBundle.new(name: 'Kit Panos')
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
      ProductBundle.create!(name: 'Kit Panos')
      pb = ProductBundle.new(name: 'Kit Panos')

      # Act
      result = pb.valid?

      # Assert
      expect(result).to eq false
    end

    it 'sku' do
      # Arrange
      pb1 = ProductBundle.create!(name: 'Kit Sacolas')
      pb2 = ProductBundle.new(name: 'Kit Panos')
      sku = pb1.sku
      allow(SecureRandom).to receive(:alphanumeric).with(17).and_return sku
      pb2.save()
  
      # Act
      result = pb2.valid?
  
      # Assert
      expect(result).to eq false
    end
  end

  it 'should generate an SKU with 21 characters' do
    # Arrange
    pb = ProductBundle.new(name: 'Kit Panos')

    # Act
    pb.save()

    # Assert
    expect(pb.sku).not_to eq nil
    expect(pb.sku.length).to eq 21
  end

  it 'should generate a random SKU' do
    # Arrange
    pb = ProductBundle.new(name: 'Kit Panos')
    allow(SecureRandom).to receive(:alphanumeric).with(17).and_return 'XjDED8ylT4hFzqVnl'

    # Act
    pb.save()    
    
    # Assert
    expect(pb.sku).to eq 'KSKUXjDED8ylT4hFzqVnl'
  end

  context 'should not be valid if sku is in wrong format' do
    it 'KSKUa4s582d4f536f4g7h4ytr' do
      # Arrange
      pb = ProductBundle.new(name: 'Kit Panos')
      allow(SecureRandom).to receive(:alphanumeric).with(17).and_return 'KSKUa4s582d4f536f4g7h4ytr'

      # Act
      result = pb.valid?
    
      # Assert
      expect(result).to eq false
    end

    it 'SKUa4s582d4f536f4g7h4' do
      # Arrange
      pb = ProductBundle.new(name: 'Kit Panos')
      allow(SecureRandom).to receive(:alphanumeric).with(17).and_return 'KSKUa4s582d4f536f4g7h4'

      # Act
      result = pb.valid?
    
      # Assert
      expect(result).to eq false
    end
  end
end
