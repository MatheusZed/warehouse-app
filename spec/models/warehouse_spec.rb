require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  it 'should not be valid if name is empty' do
    # Arrange
    wh = Warehouse.new(name: '', code: 'AMZ', description: 'Codigo legal',
                       address: 'Av Amazonas', city: 'Amazonas', state: 'AM',
                       postal_code:'70510-000', total_area: 10000, useful_area: 8000)

    # Act
    result = wh.valid?

    # Assert
    expect(result).to eq false
  end

  it 'should not be valid if code is empty' do
    # Arrange
    wh = Warehouse.new(name: 'Amazonas', code: '', description: 'Codigo legal',
                       address: 'Av Amazonas', city: 'Amazonas', state: 'AM',
                       postal_code:'70510-000', total_area: 10000, useful_area: 8000)

    # Act
    result = wh.valid?

    # Assert
    expect(result).to eq false
  end

  it 'should not be valid if description is empty' do
    # Arrange
    wh = Warehouse.new(name: 'Amazonas', code: 'AMZ', description: '',
                       address: 'Av Amazonas', city: 'Amazonas', state: 'AM',
                       postal_code:'70510-000', total_area: 10000, useful_area: 8000)

    # Act
    result = wh.valid?

    # Assert
    expect(result).to eq false
  end

  it 'should not be valid if address is empty' do
    # Arrange
    wh = Warehouse.new(name: 'Amazonas', code: 'AMZ', description: 'Codigo legal',
                       address: '', city: 'Amazonas', state: 'AM',
                       postal_code:'70510-000', total_area: 10000, useful_area: 8000)

    # Act
    result = wh.valid?

    # Assert
    expect(result).to eq false    
  end

  it 'should not be valid if city is empty' do
    # Arrange
    wh = Warehouse.new(name: 'Amazonas', code: 'AMZ', description: 'Codigo legal',
                       address: 'Av Amazonas', city: '', state: 'AM',
                       postal_code:'70510-000', total_area: 10000, useful_area: 8000)

    # Act
    result = wh.valid?

    # Assert
    expect(result).to eq false
  end

  it 'should not be valid if state is empty' do
    # Arrange
    wh = Warehouse.new(name: 'Amazonas', code: 'AMZ', description: 'Codigo legal',
                       address: 'Av Amazonas', city: 'Amazonas', state: '',
                       postal_code:'70510-000', total_area: 10000, useful_area: 8000)

    # Act
    result = wh.valid?

    # Assert
    expect(result).to eq false
  end

  it 'should not be valid if postal code is empty' do
    # Arrange
    wh = Warehouse.new(name: 'Amazonas', code: 'AMZ', description: 'Codigo legal',
                       address: 'Av Amazonas', city: 'Amazonas', state: 'AM',
                       postal_code:'', total_area: 10000, useful_area: 8000)

    # Act
    result = wh.valid?

    # Assert
    expect(result).to eq false
  end

  it 'should not be valid if total area is empty' do
    # Arrange
    wh = Warehouse.new(name: 'Amazonas', code: 'AMZ', description: 'Codigo legal',
                       address: 'Av Amazonas', city: 'Amazonas', state: 'AM',
                       postal_code:'70510-000', total_area: nil, useful_area: 8000)

    # Act
    result = wh.valid?

    # Assert
    expect(result).to eq false
  end

  it 'should not be valid if useful area is empty' do
    # Arrange
    wh = Warehouse.new(name: 'Amazonas', code: 'AMZ', description: 'Codigo legal',
                       address: 'Av Amazonas', city: 'Amazonas', state: 'AM',
                       postal_code:'705100-000', total_area: 10000, useful_area: nil)

    # Act
    result = wh.valid?

    # Assert
    expect(result).to eq false
  end

  it 'should not be valid if name is duplicate' do
    # Arrange
    wh1 = Warehouse.create(name: 'Amazonas', code: 'AMZ', description: 'Codigo legal',
                           address: 'Av Amazonas', city: 'Amazonas', state: 'AM',
                           postal_code:'70510-000', total_area: 10000, useful_area: 8000)

    wh2 = Warehouse.new(name: 'Amazonas', code: 'AMA', description: 'Otimo galpao mas frio',
                        address: 'Av Amazonas', city: 'Amazonas', state: 'AM',
                        postal_code:'70500-000', total_area: 15000, useful_area: 12000)

    # Act
    result = wh2.valid?

    # Assert
    expect(result).to eq false
  end

  it 'should not be valid if code is duplicate' do
    # Arrange
    wh1 = Warehouse.create(name: 'Vitoria', code: 'VIX', description: 'Codigo legal',
                           address: 'Av Vitoria', city: 'Vitoria', state: 'ES',
                           postal_code:'55000-000', total_area: 10000, useful_area: 8000)

    wh2 = Warehouse.new(name: 'Curitiba', code: 'VIX', description: 'Otimo galpao mas frio',
                        address: 'Av Curitiba', city: 'Curitiba', state: 'PR',
                        postal_code:'70500-000', total_area: 15000, useful_area: 12000)

    # Act
    result = wh2.valid?

    # Assert
    expect(result).to eq false
  end

  context "should not be valid if cep is in wrong format" do
    it 'cep eq 705' do
      # Arrange
      wh = Warehouse.new(name: 'Curitiba', code: 'VIX', description: 'Otimo galpao mas frio',
                       address: 'Av Curitiba', city: 'Curitiba', state: 'PR',
                       postal_code:'705', total_area: 15000, useful_area: 12000)
                       
      # Act
      result = wh.valid?
    
      # Assert
      expect(result).to eq false
    end

    it 'cep eq 700000-00' do
      # Arrange
      wh = Warehouse.new(name: 'Curitiba', code: 'VIX', description: 'Otimo galpao mas frio',
                        address: 'Av Curitiba', city: 'Curitiba', state: 'PR',
                        postal_code:'700000-00', total_area: 15000, useful_area: 12000)

      # Act
      result = wh.valid?

      # Assert
      expect(result).to eq false
    end

    it 'cep eq aaaaa-aaa' do
      # Arrange
      wh = Warehouse.new(name: 'Curitiba', code: 'VIX', description: 'Otimo galpao mas frio',
                        address: 'Av Curitiba', city: 'Curitiba', state: 'PR',
                        postal_code:'aaaaa-aaa', total_area: 15000, useful_area: 12000)
                        
                        # Act
      result = wh.valid?
      
      # Assert
      expect(result).to eq false
    end

    it 'cep eq 111112-111' do
      # Arrange
      wh = Warehouse.new(name: 'Curitiba', code: 'VIX', description: 'Otimo galpao mas frio',
                        address: 'Av Curitiba', city: 'Curitiba', state: 'PR',
                        postal_code:'111112-111', total_area: 15000, useful_area: 12000)
                        
                        # Act
      result = wh.valid?
      
      # Assert
      expect(result).to eq false
    end

    it 'cep eq 11111-1112' do
      # Arrange
      wh = Warehouse.new(name: 'Curitiba', code: 'VIX', description: 'Otimo galpao mas frio',
                        address: 'Av Curitiba', city: 'Curitiba', state: 'PR',
                        postal_code:'11111-1112', total_area: 15000, useful_area: 12000)
                        
                        # Act
      result = wh.valid?
      
      # Assert
      expect(result).to eq false
    end
  end
end
