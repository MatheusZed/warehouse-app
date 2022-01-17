require 'rails_helper'

describe 'Supplier API' do
  context 'GET api/v1/suppliers' do
    it 'successfuly' do
      # Arrange
      Supplier.create!(fantasy_name: 'Joao', legal_name: 'Joao e os doces',
                       cnpj: '22416076000135', address: 'Rua Benedito Spinardi',
                       email: 'joao.doceria@yahoo.com', phone: '91124-2854')
      Supplier.create!(fantasy_name: 'Maria', legal_name: 'Maria e os doces',
                       cnpj: '22416076000138', address: 'Rua Benedito Spinardi',
                       email: 'maria.doceria@yahoo.com', phone: '91125-2854')
                           
                          
      # Act
      get '/api/v1/suppliers'
          
      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      parsed_response = JSON.parse(response.body)
      expect(parsed_response[0]["fantasy_name"]).to eq 'Joao'
      expect(parsed_response[0]["legal_name"]).to eq 'Joao e os doces'
      expect(parsed_response[1]["fantasy_name"]).to eq 'Maria'
      expect(parsed_response[1]["legal_name"]).to eq 'Maria e os doces'
      expect(parsed_response[0].keys).not_to include 'created_at'
      expect(parsed_response[0].keys).not_to include 'updated_at'
      expect(parsed_response[0].keys).not_to include 'cnpj'
      expect(parsed_response[0].keys).not_to include 'address'
      expect(parsed_response[1].keys).not_to include 'created_at'
      expect(parsed_response[1].keys).not_to include 'updated_at'
      expect(parsed_response[1].keys).not_to include 'cnpj'
      expect(parsed_response[1].keys).not_to include 'address'
    end
    
    it 'empty response' do
      # Act
      get '/api/v1/suppliers'
      
      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).to eq []
    end
  end

  context 'GET /api/v1/suppliers/:id' do
    it 'successfully' do
      # Arrange
      s = Supplier.create!(fantasy_name: 'Joao', legal_name: 'Joao e os doces',
                           cnpj: '22416076000135', address: 'Rua Benedito Spinardi',
                           email: 'joao.doceria@yahoo.com', phone: '91124-2854')

      # Act
      get "/api/v1/suppliers/#{s.id}"

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["fantasy_name"]).to eq 'Joao'
      expect(parsed_response["legal_name"]).to eq 'Joao e os doces'
      expect(parsed_response.keys).not_to include 'created_at'
      expect(parsed_response.keys).not_to include 'updated_at'
      expect(parsed_response.keys).not_to include 'cnpj'
      expect(parsed_response.keys).not_to include 'address'
    end

    it "warehouse doesn't exist" do
      # Act
      get '/api/v1/suppliers/999'
      
      # Assert
      expect(response.status).to eq 404
    end
  end
end
