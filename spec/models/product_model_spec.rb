require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  it '.dimension' do
    # Arrange
    p = ProductModel.new(height: '14', width: '10', length: '12')

    # Act
    result = p.dimensions()
    
    # Assert
    expect(result).to eq '14 x 10 x 12'
  end

  context 'should not be valid if the fields are empty' do
    it 'name' do
      # Arrange
      s = Supplier.create!(fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
                           cnpj: '30605809000108', address: 'Av Fernandes Lima',
                           email: 'joao.feijao@yahoo.com', phone: '91124-7753')

      pm = ProductModel.new(name: '', weight: 1000, height: 4,
                            width: 17, length: 22, supplier: s, sku: 'I12A')

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end

    it 'weight' do
      # Arrange
      s = Supplier.create!(fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
                           cnpj: '30605809000108', address: 'Av Fernandes Lima',
                           email: 'joao.feijao@yahoo.com', phone: '91124-7753')

      pm = ProductModel.new(name: 'Saco de Feijao', weight: '', height: 4,
                            width: 17, length: 22, supplier: s, sku: 'I12A')

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end

    it 'height' do
      # Arrange
      s = Supplier.create!(fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
                           cnpj: '30605809000108', address: 'Av Fernandes Lima',
                           email: 'joao.feijao@yahoo.com', phone: '91124-7753')

      pm = ProductModel.new(name: 'Saco de Feijao', weight: 1000, height: '',
                            width: 17, length: 22, supplier: s, sku: 'I12A')

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end

    it 'width' do
      # Arrange
      s = Supplier.create!(fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
                           cnpj: '30605809000108', address: 'Av Fernandes Lima',
                           email: 'joao.feijao@yahoo.com', phone: '91124-7753')

      pm = ProductModel.new(name: 'Saco de Feijao', weight: 1000, height: 4,
                            width: '', length: 22, supplier: s, sku: 'I12A')

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end

    it 'length' do
      # Arrange
      s = Supplier.create!(fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
                           cnpj: '30605809000108', address: 'Av Fernandes Lima',
                           email: 'joao.feijao@yahoo.com', phone: '91124-7753')

      pm = ProductModel.new(name: 'Saco de Feijao', weight: 1000, height: 4,
                            width: 17, length: '', supplier: s, sku: 'I12A')

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end

    it 'supplier' do
      # Arrange
      pm = ProductModel.new(name: 'Saco de Feijao', weight: 1000, height: 4,
                               width: 17, length: 22, supplier_id: '', sku: 'I12A')

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end

    it 'sku' do
      # Arrange
      s = Supplier.create!(fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
                           cnpj: '30605809000108', address: 'Av Fernandes Lima',
                           email: 'joao.feijao@yahoo.com', phone: '91124-7753')

      pm = ProductModel.new(name: 'Saco de Feijao', weight: 1000, height: 4,
                            width: 17, length: 22, supplier: s, sku: '')

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end
  end

  it 'should not be valid if sku is duplicate' do
    # Arrange
    s = Supplier.create!(fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
                         cnpj: '30605809000108', address: 'Av Fernandes Lima',
                         email: 'joao.feijao@yahoo.com', phone: '91124-7753')
    ProductModel.create!(name: 'Saco de Feijao', weight: 1000, height: 4,
                         width: 17, length: 22, supplier: s, sku: 'I12A')
    pm = ProductModel.new(name: 'Vaca', weight: 100000, height: 140,
                          width: 143, length: 138, supplier: s, sku: 'I12A')

    # Act
    result = pm.valid?

    # Assert
    expect(result).to eq false
  end

  context 'must not be valid if the fields are less than one' do
    it 'weight' do
      # Arrange
      s = Supplier.create!(fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
                           cnpj: '30605809000108', address: 'Av Fernandes Lima',
                           email: 'joao.feijao@yahoo.com', phone: '91124-7753')
      pm = ProductModel.new(name: 'Vaca', weight: 0, height: 140,
                            width: 143, length: 138, supplier: s, sku: 'I12A')

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end

    it 'height' do
      # Arrange
      s = Supplier.create!(fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
                           cnpj: '30605809000108', address: 'Av Fernandes Lima',
                           email: 'joao.feijao@yahoo.com', phone: '91124-7753')
      pm = ProductModel.new(name: 'Vaca', weight: 100000, height: 0,
                            width: 143, length: 138, supplier: s, sku: 'I12A')

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end

    it 'width' do
      # Arrange
      s = Supplier.create!(fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
                           cnpj: '30605809000108', address: 'Av Fernandes Lima',
                           email: 'joao.feijao@yahoo.com', phone: '91124-7753')
      pm = ProductModel.new(name: 'Vaca', weight: 100000, height: 140,
                            width: 0, length: 138, supplier: s, sku: 'I12A')

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end

    it 'length' do
      # Arrange
      s = Supplier.create!(fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
                           cnpj: '30605809000108', address: 'Av Fernandes Lima',
                           email: 'joao.feijao@yahoo.com', phone: '91124-7753')
      pm = ProductModel.new(name: 'Vaca', weight: 100000, height: 140,
                            width: 143, length: 0, supplier: s, sku: 'I12A')

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end
  end  
end
