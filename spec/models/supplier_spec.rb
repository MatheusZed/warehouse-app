require 'rails_helper'

RSpec.describe Supplier, type: :model do
  context 'should not be valid if the fields are empty' do
    it 'fantasy name' do
      # Arrange
      sp = build(:supplier, fantasy_name: '')

      # Act
      result = sp.valid?

      # Assert
      expect(result).to eq false
    end

    it 'legal name' do
      # Arrange
      sp = build(:supplier, legal_name: '')

      # Act
      result = sp.valid?

      # Assert
      expect(result).to eq false
    end

    it 'cnpj' do
      # Arrange
      sp = build(:supplier, cnpj: '')

      # Act
      result = sp.valid?

      # Assert
      expect(result).to eq false
    end

    it 'email' do
      # Arrange
      sp = build(:supplier, email: '')

      # Act
      result = sp.valid?

      # Assert
      expect(result).to eq false
    end
  end

  it 'should not be valid if cnpj is duplicate' do
    # Arrange
    create(:supplier, cnpj: '11547895484753')
    sp = build(:supplier, cnpj: '11547895484753')

    # Act
    result = sp.valid?

    # Assert
    expect(result).to eq false
  end

  context 'should not be valid if cnpj is in wrong format' do
    it 'cnpj eq 30605809000' do
      # Arrange
      sp = build(:supplier, cnpj: '30605809000')

      # Act
      result = sp.valid?

      # Assert
      expect(result).to eq false
    end

    it 'cnpj eq 306058090001089' do
      # Arrange
      sp = build(:supplier, cnpj: '306058090001089')

      # Act
      result = sp.valid?

      # Assert
      expect(result).to eq false
    end

    it 'cnpj eq aaaaaaaaaaaaa' do
      # Arrange
      sp = build(:supplier, cnpj: 'aaaaaaaaaaaaa')

      # Act
      result = sp.valid?

      # Assert
      expect(result).to eq false
    end
  end
end
