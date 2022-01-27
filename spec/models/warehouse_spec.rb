require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  let(:pc) { create(:product_category, name: "Conservados") }

  context 'should not be valid if the fields are empty' do
    it 'name' do
      # Arrange
      wh = build(:warehouse, name: '', product_category_ids: [pc.id])

      # Act
      result = wh.valid?

      # Assert
      expect(result).to eq false
    end

    it 'code' do
      # Arrange
      wh = build(:warehouse, code: '', product_category_ids: [pc.id])

      # Act
      result = wh.valid?

      # Assert
      expect(result).to eq false
    end

    it 'description' do
      # Arrange
      wh = build(:warehouse, description: '', product_category_ids: [pc.id])

      # Act
      result = wh.valid?

      # Assert
      expect(result).to eq false
    end

    it 'address' do
      # Arrange
      wh = build(:warehouse, address: '', product_category_ids: [pc.id])

      # Act
      result = wh.valid?

      # Assert
      expect(result).to eq false
    end

    it 'city' do
      # Arrange
      wh = build(:warehouse, city: '', product_category_ids: [pc.id])

      # Act
      result = wh.valid?

      # Assert
      expect(result).to eq false
    end

    it 'state' do
      # Arrange
      wh = build(:warehouse, state: '', product_category_ids: [pc.id])

      # Act
      result = wh.valid?

      # Assert
      expect(result).to eq false
    end

    it 'postal code' do
      # Arrange
      wh = build(:warehouse, postal_code: '', product_category_ids: [pc.id])

      # Act
      result = wh.valid?

      # Assert
      expect(result).to eq false
    end

    it 'total area' do
      # Arrange
      wh = build(:warehouse, total_area: '', product_category_ids: [pc.id])

      # Act
      result = wh.valid?

      # Assert
      expect(result).to eq false
    end

    it 'useful area' do
      # Arrange
      wh = build(:warehouse, useful_area: '', product_category_ids: [pc.id])

      # Act
      result = wh.valid?

      # Assert
      expect(result).to eq false
    end

    it 'product category' do
      # Arrange
      wh = build(:warehouse, product_category_ids: [])

      # Act
      result = wh.valid?

      # Assert
      expect(result).to eq false
    end
  end

  it 'should not be valid if name is duplicate' do
    # Arrange
    create(:warehouse, name: 'Amazonas', product_category_ids: [pc.id])
    wh = build(:warehouse, name: 'Amazonas', product_category_ids: [pc.id])

    # Act
    result = wh.valid?

    # Assert
    expect(result).to eq false
  end

  it 'should not be valid if code is duplicate' do
    # Arrange
    create(:warehouse, code: 'VIX', product_category_ids: [pc.id])
    wh = build(:warehouse, code: 'VIX', product_category_ids: [pc.id])

    # Act
    result = wh.valid?

    # Assert
    expect(result).to eq false
  end

  context 'should not be valid if cep is in wrong format' do
    it 'cep eq 705' do
      # Arrange
      wh = build(:warehouse, postal_code: '705', product_category_ids: [pc.id])

      # Act
      result = wh.valid?

      # Assert
      expect(result).to eq false
    end

    it 'cep eq 700000-00' do
      # Arrange
      wh = build(:warehouse, postal_code: '700000-00', product_category_ids: [pc.id])

      # Act
      result = wh.valid?

      # Assert
      expect(result).to eq false
    end

    it 'cep eq aaaaa-aaa' do
      # Arrange
      wh = build(:warehouse, postal_code: 'aaaaa-aaa', product_category_ids: [pc.id])

      # Act
      result = wh.valid?

      # Assert
      expect(result).to eq false
    end

    it 'cep eq 111112-111' do
      # Arrange
      wh = build(:warehouse, postal_code: '111112-111', product_category_ids: [pc.id])

      # Act
      result = wh.valid?

      # Assert
      expect(result).to eq false
    end

    it 'cep eq 11111-1112' do
      # Arrange
      wh = build(:warehouse, postal_code: '11111-1112', product_category_ids: [pc.id])

      # Act
      result = wh.valid?

      # Assert
      expect(result).to eq false
    end
  end
end
