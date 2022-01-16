require 'rails_helper'

describe 'Warehouse API' do
  context 'GET api/v1/warehouses' do    
      it 'successfuly' do
        # Arrange
        Warehouse.create!(name: 'Alimenticio', code: 'ALM', description: 'Otimo galpao numa linda cidade',
                        address: 'Av Fernandes Lima', city: 'Maceio', state: 'AL',
                        postal_code:'57050-000', total_area: 10000, useful_area: 8000)
                        Warehouse.create!(name: 'Roupas', code: 'RUP', description: 'Otimo galpao com precos baixos',
                          address: 'Av Fernandes Cronus', city: 'Maceio', state: 'AL',
                        postal_code:'57051-000', total_area: 10000, useful_area: 8000)
                        
      # Act
      get '/api/v1/warehouses'
      
      # Assert
      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(parsed_response[0]["name"]).to eq 'Alimenticio'
      expect(parsed_response[1]["name"]).to eq 'Roupas'
      expect(response.body).not_to include 'Av Fernandes Lima'
      expect(response.body).not_to include 'Av Fernandes Cronus'
    end
    
    it 'empty response' do
      # Act
      get '/api/v1/warehouses'
      
      # Assert
      parsed_response = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(parsed_response).to eq []
    end
  end
end
