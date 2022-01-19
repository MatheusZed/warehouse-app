require 'rails_helper'

describe 'Warehouse API' do
  context 'GET api/v1/warehouses' do
    it 'successfuly' do
      # Arrange
      pc = ProductCategory.create!(
        name: 'Conservados'
      )
      Warehouse.create!(
        name: 'Alimenticio', code: 'ALM', description: 'Otimo galpao numa linda cidade', state: 'AL',
        address: 'Av Fernandes Lima', city: 'Maceio', postal_code:'57050-000',
        total_area: 10000, useful_area: 8000, product_category_ids: [pc.id]
      )
      Warehouse.create!(
        name: 'Roupas', code: 'RUP', description: 'Otimo galpao com precos baixos', state: 'AL',
        address: 'Av Fernandes Cronus', city: 'Maceio', postal_code:'57051-000',
        total_area: 10000, useful_area: 8000 , product_category_ids: [pc.id]
      )

      # Act
      get '/api/v1/warehouses'

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      parsed_response = JSON.parse(response.body)
      expect(parsed_response[0]["name"]).to eq 'Alimenticio'
      expect(parsed_response[1]["name"]).to eq 'Roupas'
      expect(response.body).not_to include 'Av Fernandes Lima'
      expect(parsed_response[0]["product_category_warehouses"][0]["product_category_id"]).to eq pc.id
      expect(response.body).not_to include 'Av Fernandes Cronus'
      expect(parsed_response[1]["product_category_warehouses"][0]["product_category_id"]).to eq pc.id
      expect(parsed_response[0].keys).not_to include 'created_at'
      expect(parsed_response[0].keys).not_to include 'updated_at'
      expect(parsed_response[1].keys).not_to include 'created_at'
      expect(parsed_response[1].keys).not_to include 'updated_at'
    end

    it 'empty response' do
      # Act
      get '/api/v1/warehouses'

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).to eq []
    end
  end

  context 'GET /api/v1/warehouses/:id' do
    it 'successfully' do
      # Arrange
      pc = ProductCategory.create!(
        name: 'Conservados'
      )
      w = Warehouse.create!(
        name: 'Alimenticio', code: 'ALM', description: 'Otimo galpao', state: 'AL',
        address: 'Av Fernandes Lima', city: 'Maceio', postal_code:'57050-000',
        total_area: 10000, useful_area: 8000, product_category_ids: [pc.id]
      )

      # Act
      get "/api/v1/warehouses/#{w.id}"

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["name"]).to eq 'Alimenticio'
      expect(parsed_response["code"]).to eq 'ALM'
      expect(parsed_response["city"]).to eq 'Maceio'
      expect(parsed_response["product_category_warehouses"][0]["product_category_id"]).to eq pc.id
      expect(parsed_response.keys).not_to include 'created_at'
      expect(parsed_response.keys).not_to include 'updated_at'
    end

    it "warehouse doesn't exist" do
      # Act
      get '/api/v1/warehouses/999'

      # Assert
      expect(response.status).to eq 404
      expect(response.content_type).to include 'application/json'
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["error"]).to eq 'Objeto nao encontrado'
    end
  end

  context 'POST /api/v1/warehouses' do
    it 'successfully' do
      # Arrange
      pc = ProductCategory.create!(
        name: 'Conservados'
      )

      # Act
      headers = { "Content-Type " => "application/json"}
      params = { 
        name: 'Osasco', code: 'OZC', description: 'Galpao de alto volume',
        address: 'Av. Santo Antonio, 200', city: 'Osasco', state: 'SP',
        postal_code: '06162-000', total_area: 2000, useful_area: 1900,
        product_category_ids: [pc.id]
      }
      post '/api/v1/warehouses', params: params, headers: headers

      # Assert
      expect(response.status).to eq 201
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["id"]).to be_a_kind_of(Integer)
      expect(parsed_response["name"]).to eq 'Osasco'
      expect(parsed_response["code"]).to eq 'OZC'
      expect(parsed_response["product_category_warehouses"][0]["product_category_id"]).to eq pc.id
      expect(parsed_response.keys).not_to include 'created_at'
      expect(parsed_response.keys).not_to include 'updated_at'
    end

    it 'has required fields' do
      # Act
      headers = { "Content-Type " => "application/json"}
      params = { name: 'Osasco', address: 'Av. Santo Antonio, 200', city: 'Osasco',
                 state: 'SP', total_area: 2000, useful_area: 1900 }
      post '/api/v1/warehouses', params: params, headers: headers

      # Assert
      expect(response.status).to eq 422
      expect(response.body).to include 'Codigo não pode ficar em branco'
      expect(response.body).to include 'Descricao não pode ficar em branco'
      expect(response.body).to include 'CEP não pode ficar em branco'
      expect(response.body).to include 'Categorias de Produto : é necessario selecionar no minimo 1'
    end

    it "name isn't unique" do
      # Arrange
      pc = ProductCategory.create!(
        name: 'Conservados'
      )
      Warehouse.create!(
        name: 'Alimenticio', code: 'ALM', description: 'Otimo galpao numa linda cidade com luzes',
        address: 'Av Fernandes Lima', city: 'Maceio', state: 'AL', postal_code:'57050-000',
        total_area: 10000, useful_area: 8000, product_category_ids: [pc.id] 
      )

      # Act
      headers = { "Content-Type " => "application/json"}
      params = { 
        name: 'Alimenticio', code: 'OSC', description: 'Galpao de alto volume',
        address: 'Av. Santo Antonio, 200', city: 'Osasco', state: 'SP', 
        postal_code: '06162-000', total_area: 2000, useful_area: 1900,
        product_category_ids: [pc.id] 
      }
      post '/api/v1/warehouses', params: params, headers: headers

      # Assert
      expect(response.status).to eq 422
      expect(response.body).to include 'Nome já está em uso'
    end

    it "code isn't unique" do
      # Arrange
      pc = ProductCategory.create!(
        name: 'Conservados'
      )
      Warehouse.create!(
        name: 'Alimenticio', code: 'ALM', description: 'Otimo galpao numa linda cidade com luzes',
        address: 'Av Fernandes Lima', city: 'Maceio', state: 'AL', postal_code:'57050-000',
        total_area: 10000, useful_area: 8000, product_category_ids: [pc.id] 
      )

      # Act
      headers = { "Content-Type " => "application/json"}
      params = { 
        name: 'Osasco', code: 'ALM', description: 'Galpao de alto volume',
        address: 'Av. Santo Antonio, 200', city: 'Osasco', state: 'SP',
        postal_code: '06162-000', total_area: 2000, useful_area: 1900,
        product_category_ids: [pc.id] 
      }
      post '/api/v1/warehouses', params: params, headers: headers

      # Assert
      expect(response.status).to eq 422
      expect(response.body).to include 'Codigo já está em uso'
    end

    it 'CEP in wrong format' do
      # Arrange
      pc = ProductCategory.create!(
        name: 'Conservados'
      )

      # Act
      headers = { "Content-Type " => "application/json"}
      params = { 
        name: 'Osasco', code: 'ALM', description: 'Galpao de alto volume',
        address: 'Av. Santo Antonio, 200', city: 'Osasco', state: 'SP',
        postal_code: '061622-000', total_area: 2000, useful_area: 1900,
        product_category_ids: [pc.id]
      }
      post '/api/v1/warehouses', params: params, headers: headers

      # Assert
      expect(response.status).to eq 422
      expect(response.body).to include 'CEP não é valido, formato: 00000-000'
    end
  end

  context 'PUT /api/v1/warehouses/:id' do
    it 'successfully' do
      # Arrange
      pc = ProductCategory.create!(
        name: 'Conservados'
      )
      w = Warehouse.create!(
        name: 'Alimenticio', code: 'ALM', description: 'Otimo galpao numa linda cidade com luzes',
        address: 'Av Fernandes Lima', city: 'Maceio', state: 'AL', postal_code:'57050-000',
        total_area: 10000, useful_area: 8000, product_category_ids: [pc.id]
      )

      # Act
      headers = { "Content-Type " => "application/json"}
      params = { name: 'Osasco', code: 'OZC' }
      put "/api/v1/warehouses/#{w.id}", params: params, headers: headers

      # Assert
      expect(response.status).to eq 201
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["id"]).to be_a_kind_of(Integer)
      expect(parsed_response["name"]).to eq 'Osasco'
      expect(parsed_response["code"]).to eq 'OZC'
      expect(parsed_response["product_category_warehouses"][0]["product_category_id"]).to eq pc.id
      expect(parsed_response.keys).not_to include 'created_at'
      expect(parsed_response.keys).not_to include 'updated_at'
    end

    it "and can't edit" do
      # Arrange
      pc = ProductCategory.create!(
        name: 'Conservados'
      )
      w = Warehouse.create!(
        name: 'Alimenticio', code: 'ALM', description: 'Otimo galpao numa linda cidade com luzes',
        address: 'Av Fernandes Lima', city: 'Maceio', state: 'AL', postal_code:'57050-000',
        total_area: 10000, useful_area: 8000, product_category_ids: [pc.id]
      )

      # Act
      headers = { "Content-Type " => "application/json"}
      params = { name: '' }
      put "/api/v1/warehouses/#{w.id}", params: params, headers: headers

      # Assert
      expect(response.status).to eq 422
      expect(response.body).to include "Nome não pode ficar em branco"
    end

    it "warehouse doesn't exist" do
      # Act
      put '/api/v1/warehouses/999'

      # Assert
      expect(response.status).to eq 404
      expect(response.content_type).to include 'application/json'
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["error"]).to eq 'Objeto nao encontrado'
    end
  end
end
