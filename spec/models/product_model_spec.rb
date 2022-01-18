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
      s = Supplier.create!(
        fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
        cnpj: '30605809000108', address: 'Av Fernandes Lima',
        email: 'joao.feijao@yahoo.com', phone: '91124-7753'
      )
      pc = ProductCategory.create!(
        name: 'Enlatados'
      )
      pm = ProductModel.new(
        name: '', weight: 1000, height: 4, width: 17, 
        length: 22, supplier: s, product_category: pc
      )

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end

    it 'weight' do
      # Arrange
      s = Supplier.create!(
        fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
        cnpj: '30605809000108', address: 'Av Fernandes Lima',
        email: 'joao.feijao@yahoo.com', phone: '91124-7753'
      )
      pc = ProductCategory.create!(
        name: 'Enlatados'
      )
      pm = ProductModel.new(
        name: 'Saco de Feijao', weight: '', height: 4, width: 17, 
        length: 22, supplier: s, product_category: pc
      )

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end

    it 'height' do
      # Arrange
      s = Supplier.create!(
        fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
        cnpj: '30605809000108', address: 'Av Fernandes Lima',
        email: 'joao.feijao@yahoo.com', phone: '91124-7753'
      )
      pc = ProductCategory.create!(
        name: 'Enlatados'
      )
      pm = ProductModel.new(
        name: 'Saco de Feijao', weight: 1000, height: '', width: 17,
        length: 22, supplier: s, product_category: pc
      )

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end

    it 'width' do
      # Arrange
      s = Supplier.create!(
        fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
        cnpj: '30605809000108', address: 'Av Fernandes Lima',
        email: 'joao.feijao@yahoo.com', phone: '91124-7753'
      )
      pc = ProductCategory.create!(
        name: 'Enlatados'
      )
      pm = ProductModel.new(
        name: 'Saco de Feijao', weight: 1000, height: 4, width: '',
        length: 22, supplier: s, product_category: pc
      )

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end

    it 'length' do
      # Arrange
      s = Supplier.create!(
        fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
        cnpj: '30605809000108', address: 'Av Fernandes Lima',
        email: 'joao.feijao@yahoo.com', phone: '91124-7753'
      )
      pc = ProductCategory.create!(
        name: 'Enlatados'
      )
      pm = ProductModel.new(
        name: 'Saco de Feijao', weight: 1000, height: 4, width: 17,
        length: '', supplier: s, product_category: pc
      )

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end

    it 'supplier' do
      # Arrange
      pc = ProductCategory.create!(
        name: 'Enlatados'
      )
      pm = ProductModel.new(
        name: 'Saco de Feijao', weight: 1000, height: 4, width: 17,
        length: 22, supplier_id: '', product_category: pc
      )

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end

    it 'product category' do
      # Arrange
      s = Supplier.create!(
        fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
        cnpj: '30605809000108', address: 'Av Fernandes Lima',
        email: 'joao.feijao@yahoo.com', phone: '91124-7753'
      )
      pm = ProductModel.new(
        name: 'Saco de Feijao', weight: 1000, height: 4, width: 17,
        length: 22, supplier: s, product_category_id: ''
      )

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end

    it 'sku' do
      # Arrange
      s = Supplier.create!(
        fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
        cnpj: '30605809000108', address: 'Av Fernandes Lima',
        email: 'joao.feijao@yahoo.com', phone: '91124-7753'
      )
      pc = ProductCategory.create!(
        name: 'Enlatados'
      )
      pm = ProductModel.new(
        name: 'Saco de Feijao', weight: 1000, height: 4, width: 17,
        length: 22, supplier: s, product_category: pc
      )
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
      s = Supplier.create!(
        fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
        cnpj: '30605809000108', address: 'Av Fernandes Lima',
        email: 'joao.feijao@yahoo.com', phone: '91124-7753'
      )
      pc = ProductCategory.create!(
        name: 'Enlatados'
      )
      pm = ProductModel.new(
        name: 'Vaca', weight: 0, height: 140, width: 143,
        length: 138, supplier: s, product_category: pc
      )

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end

    it 'height' do
      # Arrange
      s = Supplier.create!(
        fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
        cnpj: '30605809000108', address: 'Av Fernandes Lima',
        email: 'joao.feijao@yahoo.com', phone: '91124-7753'
      )
      pc = ProductCategory.create!(
        name: 'Enlatados'
      )
      pm = ProductModel.new(
        name: 'Vaca', weight: 100000, height: 0, width: 143,
        length: 138, supplier: s, product_category: pc
      )

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end

    it 'width' do
      # Arrange
      s = Supplier.create!(
        fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
        cnpj: '30605809000108', address: 'Av Fernandes Lima',
        email: 'joao.feijao@yahoo.com', phone: '91124-7753'
      )
      pc = ProductCategory.create!(
        name: 'Enlatados'
      )
      pm = ProductModel.new(
        name: 'Vaca', weight: 100000, height: 140, width: 0,
        length: 138, supplier: s, product_category: pc
      )

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end

    it 'length' do
      # Arrange
      s = Supplier.create!(
        fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
        cnpj: '30605809000108', address: 'Av Fernandes Lima',
        email: 'joao.feijao@yahoo.com', phone: '91124-7753'
      )
      pc = ProductCategory.create!(
        name: 'Enlatados'
      )
      pm = ProductModel.new(
        name: 'Vaca', weight: 100000, height: 140, width: 143,
        length: 0, supplier: s, product_category: pc
      )

      # Act
      result = pm.valid?

      # Assert
      expect(result).to eq false
    end
  end

  it 'should generate an SKU with 20 characters' do
    # Arrange
    s = Supplier.create!(
      fantasy_name: 'Cleber', legal_name: 'Cleber FUNCIONA POR FAVOR',
      cnpj: '98148569511578', address: 'Av FUNCIONA FUNCIONA POR FAVOR',
      email: 'FUNCIONA@PORFAVOR.com', phone: '91124-7753'
    )
    pc = ProductCategory.create!(
      name: 'Enlatados'
    )
    p = ProductModel.new(
      name: 'Saco de Feijao', weight: 1000, height: 4, width: 17,
      length: 22, supplier: s, product_category: pc
    )

    # Act
    p.save()

    # Assert
    expect(p.sku).not_to eq nil
    expect(p.sku.length).to eq 20
  end

  it 'should generate a random SKU' do
    # Arrange
    s = Supplier.create!(
      fantasy_name: 'Cleber', legal_name: 'Cleber FUNCIONA POR FAVOR',
      cnpj: '98988565411578', address: 'Av FUNCIONA FUNCIONA POR FAVOR',
      email: 'FUNCIONA@PORFAVOR.com', phone: '91124-7753'
    )
    pc = ProductCategory.create!(
      name: 'Enlatados'
    )
    p = ProductModel.new(
      name: 'Saco de Feijao', weight: 1000, height: 4, width: 17,
      length: 22, supplier: s, product_category: pc
    )
    allow(SecureRandom).to receive(:alphanumeric).with(17).and_return 'XjDED8ylT4hFzqVnl'

    # Act
    p.save()

    # Assert
    expect(p.sku).to eq 'SKUXjDED8ylT4hFzqVnl'
  end

  it 'should generate unique SKU' do
    # Arrange
    s = Supplier.create!(
      fantasy_name: 'Cleber', legal_name: 'Cleber FUNCIONA POR FAVOR',
      cnpj: '98988565411578', address: 'Av FUNCIONA FUNCIONA POR FAVOR',
      email: 'FUNCIONA@PORFAVOR.com', phone: '91124-7753'
    )
    pc = ProductCategory.create!(
      name: 'Enlatados'
    )
    p1 = ProductModel.create!(
      name: 'Saco de Feijao', weight: 1000, height: 4, width: 17,
      length: 22, supplier: s, product_category: pc
    )
    p2 = ProductModel.new(
      name: 'Saco de Arroz', weight: 1000, height: 4, width: 17,
      length: 22, supplier: s, product_category: pc
    )
    sku = p1.sku
    allow(SecureRandom).to receive(:alphanumeric).with(17).and_return sku
    p2.save()

    # Act
    result = p2.valid?

    # Assert
    expect(result).to eq false
  end

  pending 'should not update SKU' do    
    # Arrange
    s = Supplier.create!(
      fantasy_name: 'Cleber', legal_name: 'Cleber FUNCIONA POR FAVOR',
      cnpj: '98988565411578', address: 'Av FUNCIONA FUNCIONA POR FAVOR',
      email: 'FUNCIONA@PORFAVOR.com', phone: '91124-7753'
    )
    pc = ProductCategory.create!(
      name: 'Enlatados'
    )
    p = ProductModel.new(
      name: 'Saco de Feijao', weight: 1000, height: 4, width: 17,
      length: 22, supplier: s, product_category: pc
    )
    p.save()
    sku = p.sku

    # Act
    p.update(name: 'Funcionou')

    # Assert
    expect(p.name).to eq 'Funcionou'
    expect(p.sku).to eq sku
  end

  context 'should not be valid if sku is in wrong format' do
    it 'SKUa4s582d4f536f4g7h4ytr' do
      # Arrange
      s = Supplier.create!(
        fantasy_name: 'Cleber', legal_name: 'Cleber FUNCIONA POR FAVOR',
        cnpj: '98125565411578', address: 'Av FUNCIONA FUNCIONA POR FAVOR',
        email: 'FUNCIONA@PORFAVOR.com', phone: '91124-7753'
      )
      pc = ProductCategory.create!(
        name: 'Enlatados'
      )
      p = ProductModel.new(
        name: 'Saco de Feijao', weight: 1000, height: 4, width: 17,
        length: 22, supplier: s, product_category: pc
      )
      allow(SecureRandom).to receive(:alphanumeric).with(17).and_return 'SKUa4s582d4f536f4g7h4ytr'

      # Act
      result = p.valid?

      # Assert
      expect(result).to eq false
    end

    it 'SKUa4s582d4f536f4g7h4' do
      # Arrange
      s = Supplier.create!(
        fantasy_name: 'Cleber', legal_name: 'Cleber FUNCIONA POR FAVOR',
        cnpj: '98125565411578', address: 'Av FUNCIONA FUNCIONA POR FAVOR',
        email: 'FUNCIONA@PORFAVOR.com', phone: '91124-7753'
      )
      pc = ProductCategory.create!(
        name: 'Enlatados'
      )
      p = ProductModel.new(
        name: 'Saco de Feijao', weight: 1000, height: 4, width: 17,
        length: 22, supplier: s, product_category: pc
      )
      allow(SecureRandom).to receive(:alphanumeric).with(17).and_return 'SKUa4s582d4f536f4g7h4'

      # Act
      result = p.valid?

      # Assert
      expect(result).to eq false
    end
  end
end
