require 'rails_helper'

describe 'Product Model API' do
  context 'GET api/v1/product_models' do
    it 'successfuly' do
      # Arrange
      s = Supplier.create!(fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
                           cnpj: '30605809000108', address: 'Av Fernandes Lima',
                           email: 'joao.feijao@yahoo.com', phone: '91124-7753')
      pc = ProductCategory.create!(name: 'Conservados')
      ProductModel.create!(name: 'Saco de Feijao', weight: 1000, height: 4, width: 17,
                           length: 22, supplier: s, product_category: pc)
      ProductModel.create!(name: 'Osso de Frango', weight: 5, height: 15, width: 2,
                           length: 2, supplier: s, product_category: pc)
                      
      # Act
      get '/api/v1/product_models'
        
      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      parsed_response = JSON.parse(response.body)
      expect(parsed_response[0]["name"]).to eq 'Saco de Feijao'
      expect(parsed_response[0]["dimensions"]).to eq '4 x 17 x 22'
      expect(parsed_response[0]["supplier"]["fantasy_name"]).to eq 'Joao'
      expect(parsed_response[0]["product_category"]["name"]).to eq 'Conservados'
      expect(parsed_response[1]["name"]).to eq 'Osso de Frango'
      expect(parsed_response[1]["dimensions"]).to eq '15 x 2 x 2'
      expect(parsed_response[1]["supplier"]["fantasy_name"]).to eq 'Joao'
      expect(parsed_response[1]["product_category"]["name"]).to eq 'Conservados'
      expect(parsed_response[0].keys).not_to include 'created_at'
      expect(parsed_response[0].keys).not_to include 'updated_at'
      expect(parsed_response[0]["supplier"].keys).not_to include 'created_at'
      expect(parsed_response[0]["supplier"].keys).not_to include 'updated_at'
      expect(parsed_response[0]["supplier"].keys).not_to include 'cnpj'
      expect(parsed_response[0]["supplier"].keys).not_to include 'address'
      expect(parsed_response[0]["product_category"].keys).not_to include 'created_at'
      expect(parsed_response[0]["product_category"].keys).not_to include 'updated_at'
      expect(parsed_response[1].keys).not_to include 'created_at'
      expect(parsed_response[1].keys).not_to include 'updated_at'
      expect(parsed_response[1]["supplier"].keys).not_to include 'created_at'
      expect(parsed_response[1]["supplier"].keys).not_to include 'updated_at'
      expect(parsed_response[1]["supplier"].keys).not_to include 'cnpj'
      expect(parsed_response[1]["supplier"].keys).not_to include 'address'
      expect(parsed_response[1]["product_category"].keys).not_to include 'created_at'
      expect(parsed_response[1]["product_category"].keys).not_to include 'updated_at'
    end
    
    it 'empty response' do
      # Act
      get '/api/v1/product_models'
      
      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).to eq []
    end
  end

  context 'GET /api/v1/product_models/:id' do
    it 'successfully' do
      # Arrange
      s = Supplier.create!(fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
                           cnpj: '30605809000108', address: 'Av Fernandes Lima',
                           email: 'joao.feijao@yahoo.com', phone: '91124-7753')
      pc = ProductCategory.create!(name: 'Conservados')
      pm = ProductModel.create!(name: 'Saco de Feijao', weight: 1000, height: 4, width: 17,
                                length: 22, supplier: s, product_category: pc)

      # Act
      get "/api/v1/product_models/#{pm.id}"

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["name"]).to eq 'Saco de Feijao'
      expect(parsed_response["dimensions"]).to eq '4 x 17 x 22'
      expect(parsed_response["supplier"]["fantasy_name"]).to eq 'Joao'
      expect(parsed_response["product_category"]["name"]).to eq 'Conservados'
      expect(parsed_response.keys).not_to include 'created_at'
      expect(parsed_response.keys).not_to include 'updated_at'
      expect(parsed_response["supplier"].keys).not_to include 'created_at'
      expect(parsed_response["supplier"].keys).not_to include 'updated_at'
      expect(parsed_response["supplier"].keys).not_to include 'cnpj'
      expect(parsed_response["supplier"].keys).not_to include 'address'
      expect(parsed_response["product_category"].keys).not_to include 'created_at'
      expect(parsed_response["product_category"].keys).not_to include 'updated_at'
    end
    
    it "product model doesn't exist" do
      # Act
      get '/api/v1/product_models/999'
    
      # Assert
      expect(response.status).to eq 404
      expect(response.content_type).to include 'application/json'
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["error"]).to eq 'Objeto nao encontrado'
    end
  end

  it 'database error - 500' do
    # Arrange
    s = Supplier.create!(fantasy_name: 'Joao', legal_name: 'Joao pe de feijao',
                         cnpj: '30605809000108', address: 'Av Fernandes Lima',
                         email: 'joao.feijao@yahoo.com', phone: '91124-7753')
    pc = ProductCategory.create!(name: 'Conservados')
    pm = ProductModel.create!(name: 'Saco de Feijao', weight: 1000, height: 4, width: 17,
                              length: 22, supplier: s, product_category: pc)
    allow(ProductModel).to receive(:find).with(pm.id.to_s).and_raise ActiveRecord::ConnectionNotEstablished
    
    # Act
    get "/api/v1/product_models/#{pm.id}"

    # Assert
    expect(response.status).to eq 500
    expect(response.content_type).to include 'application/json'
    parsed_response = JSON.parse(response.body)
    expect(parsed_response["error"]).to eq 'Nao foi possivel conectar ao banco de dados'
  end
end
