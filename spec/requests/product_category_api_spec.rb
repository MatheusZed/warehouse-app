require 'rails_helper'

describe 'Product Category API' do
  context 'GET api/v1/product_categories' do
    it 'successfuly' do
      # Arrange
      ProductCategory.create!(name: 'Conservados')
      ProductCategory.create!(name: 'Enlatado')

      # Act
      get '/api/v1/product_categories'

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      parsed_response = JSON.parse(response.body)
      expect(parsed_response[0]['name']).to eq 'Conservados'
      expect(parsed_response[1]['name']).to eq 'Enlatado'
      expect(parsed_response[0].keys).not_to include 'created_at'
      expect(parsed_response[0].keys).not_to include 'updated_at'
      expect(parsed_response[1].keys).not_to include 'created_at'
      expect(parsed_response[1].keys).not_to include 'updated_at'
    end

    it 'empty response' do
      # Act
      get '/api/v1/product_categories'

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).to eq []
    end
  end

  context 'GET /api/v1/product_categories/:id' do
    it 'successfully' do
      # Arrange
      pc = ProductCategory.create!(name: 'Conservados')

      # Act
      get "/api/v1/product_categories/#{pc.id}"

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['name']).to eq 'Conservados'
      expect(parsed_response.keys).not_to include 'created_at'
      expect(parsed_response.keys).not_to include 'updated_at'
    end

    it "warehouse doesn't exist" do
      # Act
      get '/api/v1/product_categories/999'

      # Assert
      expect(response.status).to eq 404
      expect(response.content_type).to include 'application/json'
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to eq 'Objeto nao encontrado'
    end
  end

  context 'POST /api/v1/product_categories' do
    it 'successfully' do
      # Act
      headers = { 'Content-Type ' => 'application/json' }
      params = { name: 'Congelados' }
      post '/api/v1/product_categories', params: params, headers: headers

      # Assert
      expect(response.status).to eq 201
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['id']).to be_a_kind_of(Integer)
      expect(parsed_response['name']).to eq 'Congelados'
      expect(parsed_response.keys).not_to include 'created_at'
      expect(parsed_response.keys).not_to include 'updated_at'
    end

    it 'has required field' do
      # Act
      headers = { 'Content-Type ' => 'application/json' }
      params = { name: '' }
      post '/api/v1/product_categories', params: params, headers: headers

      # Assert
      expect(response.status).to eq 422
      expect(response.body).to include 'Nome não pode ficar em branco'
    end

    it "name isn't unique" do
      # Arrange
      pc = ProductCategory.create!(name: 'Conservados')

      # Act
      headers = { 'Content-Type ' => 'application/json' }
      params = { name: 'Conservados' }
      post '/api/v1/product_categories', params: params, headers: headers

      # Assert
      expect(response.status).to eq 422
      expect(response.body).to include 'Nome já está em uso'
    end
  end

  context 'PUT /api/v1/product_categories/:id' do
    it 'successfully' do
      # Arrange
      pc = ProductCategory.create!(name: 'Conservados')

      # Act
      headers = { 'Content-Type ' => 'application/json' }
      params = { name: 'Enlatados' }
      put "/api/v1/product_categories/#{pc.id}", params: params, headers: headers

      # Assert
      expect(response.status).to eq 201
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['id']).to be_a_kind_of(Integer)
      expect(parsed_response['name']).to eq 'Enlatados'
      expect(parsed_response.keys).not_to include 'created_at'
      expect(parsed_response.keys).not_to include 'updated_at'
    end

    it "and can't edit" do
      # Arrange
      pc = ProductCategory.create!(name: 'Conservados')

      # Act
      headers = { 'Content-Type ' => 'application/json' }
      params = { name: '' }
      put "/api/v1/product_categories/#{pc.id}", params: params, headers: headers

      # Assert
      expect(response.status).to eq 422
      expect(response.body).to include 'Nome não pode ficar em branco'
    end

    it "warehouse doesn't exist" do
      # Act
      put '/api/v1/product_categories/999'

      # Assert
      expect(response.status).to eq 404
      expect(response.content_type).to include 'application/json'
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to eq 'Objeto nao encontrado'
    end
  end
end
