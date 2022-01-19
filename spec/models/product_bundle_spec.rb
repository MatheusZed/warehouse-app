require 'rails_helper'

RSpec.describe ProductBundle, type: :model do
  context 'should not be valid if the fields are empty' do
    it 'name' do
      # Arrage
      s = Supplier.create!(
        fantasy_name: 'Vinicola Miolo', legal_name: 'Miolo Fabrica de Bebidas LTDA',
        cnpj: '30605809000108', address: 'Av Cabernet, 100',
        email: 'contato@miolovinhos.com', phone: '71 91124-7753'
      )
      pc = ProductCategory.create!(
        name: 'Conservados'
      )
      pm1 = ProductModel.create!(
        name: 'Vinho Tinto Miolo', weight: 800, height: 30, width: 10,
        length: 10, supplier: s, product_category: pc
      )
      pm2 = ProductModel.create!(
        name: 'Taça para vinho tinto', weight: 30, height: 12, width: 10,
        length: 10, supplier: s, product_category: pc
      )
      pb = ProductBundle.new(
        name: '', product_model_ids: [pm1.id, pm2.id]
      )

      # Act
      result = pb.valid?

      # Assert
      expect(result).to eq false
    end

    it 'sku' do
      # Arrage
      s = Supplier.create!(
        fantasy_name: 'Vinicola Miolo', legal_name: 'Miolo Fabrica de Bebidas LTDA',
        cnpj: '30605809000108', address: 'Av Cabernet, 100',
        email: 'contato@miolovinhos.com', phone: '71 91124-7753'
      )
      pc = ProductCategory.create!(
        name: 'Conservados'
      )
      pm1 = ProductModel.create!(
        name: 'Vinho Tinto Miolo', weight: 800, height: 30, width: 10,
        length: 10, supplier: s, product_category: pc
      )
      pm2 = ProductModel.create!(
        name: 'Taça para vinho tinto', weight: 30, height: 12, width: 10,
        length: 10, supplier: s, product_category: pc
      )
      pb = ProductBundle.new(
        name: 'Kit Vinho', product_model_ids: [pm1.id, pm2.id]
      )
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
      s = Supplier.create!(
        fantasy_name: 'Vinicola Miolo', legal_name: 'Miolo Fabrica de Bebidas LTDA',
        cnpj: '30605809000108', address: 'Av Cabernet, 100',
        email: 'contato@miolovinhos.com', phone: '71 91124-7753'
      )
      pc = ProductCategory.create!(
        name: 'Conservados'
      )
      pm1 = ProductModel.create!(
        name: 'Vinho Tinto Miolo', weight: 800, height: 30, width: 10,
        length: 10, supplier: s, product_category: pc
      )
      pm2 = ProductModel.create!(
        name: 'Taça para vinho tinto', weight: 30, height: 12, width: 10,
        length: 10, supplier: s, product_category: pc
      )
      ProductBundle.create!(
        name: 'Kit Vinho', product_model_ids: [pm1.id, pm2.id]
      )
      pb = ProductBundle.new(
        name: 'Kit Vinho', product_model_ids: [pm1.id, pm2.id]
      )

      # Act
      result = pb.valid?

      # Assert
      expect(result).to eq false
    end

    it 'sku' do
      # Arrange
      s = Supplier.create!(fantasy_name: 'Vinicola Miolo', legal_name: 'Miolo Fabrica de Bebidas LTDA',
                           cnpj: '30605809000108', address: 'Av Cabernet, 100',
                           email: 'contato@miolovinhos.com', phone: '71 91124-7753')
      pc = ProductCategory.create!(name: 'Conservados')
      pm1 = ProductModel.create!(name: 'Vinho Tinto Miolo', weight: 800, height: 30, width: 10,
                                 length: 10, supplier: s, product_category: pc)
      pm2 = ProductModel.create!(name: 'Taça para vinho tinto', weight: 30, height: 12, width: 10,
                                 length: 10, supplier: s, product_category: pc)
      pb1 = ProductBundle.create!(name: 'Kit Vinho', product_model_ids: [pm1.id, pm2.id])
      pb2 = ProductBundle.new(name: 'Kit Vinho Gurme', product_model_ids: [pm1.id, pm2.id])
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
    s = Supplier.create!(
      fantasy_name: 'Vinicola Miolo', legal_name: 'Miolo Fabrica de Bebidas LTDA',
      cnpj: '30605809000108', address: 'Av Cabernet, 100',
      email: 'contato@miolovinhos.com', phone: '71 91124-7753'
    )
    pc = ProductCategory.create!(
      name: 'Conservados'
    )
    pm1 = ProductModel.create!(
      name: 'Vinho Tinto Miolo', weight: 800, height: 30, width: 10,
      length: 10, supplier: s, product_category: pc
    )
    pm2 = ProductModel.create!(
      name: 'Taça para vinho tinto', weight: 30, height: 12, width: 10,
      length: 10, supplier: s, product_category: pc
    )
    pb = ProductBundle.create!(
      name: 'Kit Vinho', product_model_ids: [pm1.id, pm2.id]
    )

    # Act
    pb.save()

    # Assert
    expect(pb.sku).not_to eq nil
    expect(pb.sku.length).to eq 21
  end

  it 'should generate a random SKU' do
    # Arrange
    s = Supplier.create!(
      fantasy_name: 'Vinicola Miolo', legal_name: 'Miolo Fabrica de Bebidas LTDA',
      cnpj: '30605809000108', address: 'Av Cabernet, 100',
      email: 'contato@miolovinhos.com', phone: '71 91124-7753'
    )
    pc = ProductCategory.create!(
      name: 'Conservados'
    )
    pm1 = ProductModel.create!(
      name: 'Vinho Tinto Miolo', weight: 800, height: 30, width: 10,
      length: 10, supplier: s, product_category: pc
    )
    pm2 = ProductModel.create!(
      name: 'Taça para vinho tinto', weight: 30, height: 12, width: 10,
      length: 10, supplier: s, product_category: pc
    )
    pb = ProductBundle.create!(
      name: 'Kit Vinho', product_model_ids: [pm1.id, pm2.id]
    )

    # Act
    pb.save()

    # Assert
    expect(pb.sku).to be_present
    expect(pb.sku.size).to eq(21)
  end

  context 'should not be valid if sku is in wrong format' do
    it 'KSKUa4s582d4f536f4g7h4ytr' do
      # Arrange
      s = Supplier.create!(
        fantasy_name: 'Vinicola Miolo', legal_name: 'Miolo Fabrica de Bebidas LTDA',
        cnpj: '30605809000108', address: 'Av Cabernet, 100',
        email: 'contato@miolovinhos.com', phone: '71 91124-7753'
      )
      pc = ProductCategory.create!(
        name: 'Conservados'
      )
      pm1 = ProductModel.create!(
        name: 'Vinho Tinto Miolo', weight: 800, height: 30, width: 10,
        length: 10, supplier: s, product_category: pc
      )
      pm2 = ProductModel.create!(
        name: 'Taça para vinho tinto', weight: 30, height: 12, width: 10,
        length: 10, supplier: s, product_category: pc
      )
      pb = ProductBundle.create!(
        name: 'Kit Vinho', product_model_ids: [pm1.id, pm2.id]
      )
      pb.update(sku: 'KSKUa4s582d4f536f4g7h4ytr')

      # Act
      result = pb.valid?

      # Assert
      expect(result).to eq false
    end

    it 'SKUa4s582d4f536f4g7h4' do
      # Arrange
      s = Supplier.create!(
        fantasy_name: 'Vinicola Miolo', legal_name: 'Miolo Fabrica de Bebidas LTDA',
        cnpj: '30605809000108', address: 'Av Cabernet, 100',
        email: 'contato@miolovinhos.com', phone: '71 91124-7753'
      )
      pc = ProductCategory.create!(
        name: 'Conservados'
      )
      pm1 = ProductModel.create!(
        name: 'Vinho Tinto Miolo', weight: 800, height: 30, width: 10,
        length: 10, supplier: s, product_category: pc
      )
      pm2 = ProductModel.create!(
        name: 'Taça para vinho tinto', weight: 30, height: 12, width: 10,
        length: 10, supplier: s, product_category: pc
      )
      pb = ProductBundle.create!(
        name: 'Kit Vinho', product_model_ids: [pm1.id, pm2.id]
      )
      pb.update(sku: 'KSKUa4s582d4f536f4g7h4ytr')

      # Act
      result = pb.valid?

      # Assert
      expect(result).to eq false
    end
  end

  it 'should not update SKU' do    
    # Arrange
    s = Supplier.create!(
      fantasy_name: 'Vinicola Miolo', legal_name: 'Miolo Fabrica de Bebidas LTDA',
      cnpj: '30605809000108', address: 'Av Cabernet, 100',
      email: 'contato@miolovinhos.com', phone: '71 91124-7753'
    )
    pc = ProductCategory.create!(
      name: 'Conservados'
    )
    pm1 = ProductModel.create!(
      name: 'Vinho Tinto Miolo', weight: 800, height: 30, width: 10,
      length: 10, supplier: s, product_category: pc
    )
    pm2 = ProductModel.create!(
      name: 'Taça para vinho tinto', weight: 30, height: 12, width: 10,
      length: 10, supplier: s, product_category: pc
    )
    pb = ProductBundle.create!(
      name: 'Kit Vinho', product_model_ids: [pm1.id, pm2.id]
    )
    sku = pb.sku

    # Act
    pb.update(name: 'Kit Vinheto')

    # Assert
    expect(pb.name).to eq 'Kit Vinheto'
    expect(pb.sku).to eq sku
  end
end
