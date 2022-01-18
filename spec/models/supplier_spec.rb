require 'rails_helper'

RSpec.describe Supplier, type: :model do
  context 'should not be valid if the fields are empty' do
    it 'fantasy name' do
      # Arrange
      sp1 = Supplier.new(
        fantasy_name: '', legal_name: 'Joao pe de feijao',
        cnpj: '30605809000108', address: 'Av Gigante',
        email: 'joao.feijao@yahoo.com', phone: '91124-7753'
      )

      # Act
      result = sp1.valid?

      # Assert
      expect(result).to eq false
    end

    it 'legal name' do
      # Arrange
      sp1 = Supplier.new(
        fantasy_name: 'Joao', legal_name: '',
        cnpj: '30605809000108', address: 'Av Gigante',
        email: 'joao.feijao@yahoo.com', phone: '91124-7753'
      )

      # Act
      result = sp1.valid?

      # Assert
      expect(result).to eq false
    end

    it 'cnpj' do
      # Arrange
      sp1 = Supplier.new(
        fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
        cnpj: '', address: 'Av Gigante',
        email: 'joao.feijao@yahoo.com', phone: '91124-7753'
      )

      # Act
      result = sp1.valid?

      # Assert
      expect(result).to eq false
    end

    it 'email' do
      # Arrange
      sp1 = Supplier.new(
        fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
        cnpj: '30605809000108', address: 'Av Gigante',
        email: '', phone: '91124-7753'
      )

      # Act
      result = sp1.valid?

      # Assert
      expect(result).to eq false
    end
  end

  it 'should not be valid if cnpj is duplicate' do
    # Arrange
    sp1 = Supplier.create!(
      fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
      cnpj: '30605809000108', address: 'Av Gigante', 
      email: 'joao.feijao@yahoo.com', phone: '91124-7753'
    )
    sp2 = Supplier.new(
      fantasy_name: 'Joao', legal_name: 'Joao e o doce', 
      cnpj: '30605809000108', address: 'Av Casa da Bruxa', 
      email: 'joao.doceria@yahoo.com', phone: '91124-7753'
    )

    # Act
    result = sp2.valid?

    # Assert
    expect(result).to eq false
  end

  context 'should not be valid if cnpj is in wrong format' do
    it 'cnpj eq 30605809000' do
      # Arrange
      sp = Supplier.new(
        fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
        cnpj: '30605809000', address: 'Av Gigante', 
        email: 'joao.feijao@yahoo.com', phone: '91124-7753'
      )

      # Act
      result = sp.valid?

      # Assert
      expect(result).to eq false
    end

    it 'cnpj eq 306058090001089' do
      # Arrange
      sp = Supplier.new(
        fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
        cnpj: '306058090001089', address: 'Av Gigante', 
        email: 'joao.feijao@yahoo.com', phone: '91124-7753'
      )

      # Act
      result = sp.valid?

      # Assert
      expect(result).to eq false
    end

    it 'cnpj eq aaaaaaaaaaaaa' do
      # Arrange
      sp = Supplier.new(
        fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
        cnpj: 'aaaaaaaaaaaaa', address: 'Av Gigante', 
        email: 'joao.feijao@yahoo.com', phone: '91124-7753'
      )
      
      # Act
      result = sp.valid?

      # Assert
      expect(result).to eq false
    end
  end  
end
