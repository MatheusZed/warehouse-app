require 'rails_helper'

describe 'Product Bundle API' do
  context 'GET api/v1/product_bundles' do
    it 'successfuly' do
      # Arrange
      s = Supplier.create!(
        fantasy_name: 'Maria', legal_name: 'Maria e os doces',
        cnpj: '22416076000136', address: 'Rua Benedito Spinardi',
        email: 'maria.doceria@yahoo.com', phone: '91124-2855'
      )
      pc = ProductCategory.create!(
        name: 'Conservados'
      )
      pm1 = ProductModel.create!(
        name: 'Migalhas de pao', weight: 1000, height: 4, width: 17,
        length: 22, supplier: s, product_category: pc
      )
      pm2 = ProductModel.create!(
        name: 'Osso de Frango', weight: 1000, height: 4, width: 17,
        length: 22, supplier: s, product_category: pc
      )
      pm3 = ProductModel.create!(
        name: 'Doces', weight: 1000, height: 4, width: 17,
        length: 22, supplier: s, product_category: pc
      )
      pb1 = ProductBundle.create!(
        name: 'Kit Bruxaria', product_model_ids: [pm1.id, pm2.id, pm3.id]
      )
      pb2 = ProductBundle.create!(
        name: 'Kit Xariabru', product_model_ids: [pm1.id, pm3.id]
      )

      # Act
      get '/api/v1/product_bundles'

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      parsed_response = JSON.parse(response.body)
      expect(parsed_response[0]["name"]).to eq 'Kit Bruxaria'
      expect(parsed_response[0]["product_bundle_items"][0]["product_model_id"]).to eq pm1.id
      expect(parsed_response[0]["product_bundle_items"][1]["product_model_id"]).to eq pm2.id
      expect(parsed_response[0]["product_bundle_items"][2]["product_model_id"]).to eq pm3.id
      expect(parsed_response[1]["name"]).to eq 'Kit Xariabru'
      expect(parsed_response[1]["product_bundle_items"][0]["product_model_id"]).to eq pm1.id
      expect(parsed_response[1]["product_bundle_items"][1]["product_model_id"]).to eq pm3.id
      expect(parsed_response[0].keys).not_to include 'created_at'
      expect(parsed_response[0].keys).not_to include 'updated_at'
      expect(parsed_response[1].keys).not_to include 'created_at'
      expect(parsed_response[1].keys).not_to include 'updated_at'
    end

    it 'empty response' do
      # Act
      get '/api/v1/product_bundles'

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).to eq []
    end
  end

  context 'GET /api/v1/product_bundles/:id' do
    it 'successfully' do
      # Arrange
      s = Supplier.create!(
        fantasy_name: 'Maria', legal_name: 'Maria e os doces',
        cnpj: '22416076000136', address: 'Rua Benedito Spinardi',
        email: 'maria.doceria@yahoo.com', phone: '91124-2855'
      )
      pc = ProductCategory.create!(name: 'Conservados'
      )
      pm1 = ProductModel.create!(
        name: 'Migalhas de pao', weight: 1000, height: 4, width: 17,
        length: 22, supplier: s, product_category: pc
      )
      pm2 = ProductModel.create!(
        name: 'Osso de Frango', weight: 1000, height: 4, width: 17,
        length: 22, supplier: s, product_category: pc
      )
      pm3 = ProductModel.create!(
        name: 'Doces', weight: 1000, height: 4, width: 17,
        length: 22, supplier: s, product_category: pc
      )
      pb1 = ProductBundle.create!(
        name: 'Kit Bruxaria', product_model_ids: [pm1.id, pm2.id, pm3.id]
      )

      # Act
      get "/api/v1/product_bundles/#{pb1.id}"

      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["name"]).to eq 'Kit Bruxaria'
      expect(parsed_response["product_bundle_items"][0]["product_model_id"]).to eq pm1.id
      expect(parsed_response["product_bundle_items"][1]["product_model_id"]).to eq pm2.id
      expect(parsed_response["product_bundle_items"][2]["product_model_id"]).to eq pm3.id
      expect(parsed_response.keys).not_to include 'created_at'
      expect(parsed_response.keys).not_to include 'updated_at'
    end

    it "warehouse doesn't exist" do
      # Act
      get '/api/v1/product_bundles/999'
      
      # Assert
      expect(response.status).to eq 404
      expect(response.content_type).to include 'application/json'
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["error"]).to eq 'Objeto nao encontrado'
    end
  end

  context 'POST /api/v1/product_bundle' do
    it 'successfully' do
      # Assert
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

      # Act
      headers = { "Content-Type " => "application/json"}
      params = { name: 'Kit Vinho Fim de ano', product_model_ids: [pm1.id, pm2.id]}
      post '/api/v1/product_bundles', params: params, headers: headers

      # Assert
      expect(response.status).to eq 201
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["id"]).to be_a_kind_of(Integer)      
      expect(parsed_response["name"]).to eq 'Kit Vinho Fim de ano'
      expect(parsed_response["product_bundle_items"][0]["product_model_id"]).to eq pm1.id
      expect(parsed_response["product_bundle_items"][1]["product_model_id"]).to eq pm2.id
      expect(parsed_response.keys).to include 'sku'
      expect(parsed_response.keys).not_to include 'created_at'
      expect(parsed_response.keys).not_to include 'updated_at'
    end

    it 'has required fields' do
      # Assert
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

      # Act
      headers = { "Content-Type " => "application/json"}
      params = { product_model_ids: [pm1.id, pm2.id]}
      post '/api/v1/product_bundles', params: params, headers: headers

      # Assert
      expect(response.status).to eq 422
      expect(response.body).to include 'Nome não pode ficar em branco'
    end

    it "name isn't unique" do
      # Assert
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
        name: 'Kit Panos', product_model_ids:[pm1.id, pm2.id]
      )

      # Act
      headers = { "Content-Type " => "application/json"}
      params = { name: 'Kit Panos', product_model_ids: [pm1.id, pm2.id] }
      post '/api/v1/product_bundles', params: params, headers: headers

      # Assert
      expect(response.status).to eq 422
      expect(response.body).to include 'Nome já está em uso'
    end
  end

  context 'PUT /api/v1/product_bundles/:id' do
    it 'successfully' do
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
        name: 'Migalhas de pao', weight: 1000, height: 4, width: 17,
        length: 22, supplier: s, product_category: pc
      )
      pm2 = ProductModel.create!(
        name: 'Osso de Frango', weight: 1000, height: 4, width: 17,
        length: 22, supplier: s, product_category: pc
      )
      pm3 = ProductModel.create!(
        name: 'Doces', weight: 1000, height: 4, width: 17,
        length: 22, supplier: s, product_category: pc
      )
      pb = ProductBundle.create!(
        name: 'Kit Panos', product_model_ids:[pm1.id, pm2.id]
      )

      # Act
      headers = { "Content-Type " => "application/json"}
      params = { name: 'Kit Bruxaria', product_model_ids:[pm1.id, pm3.id] }
      put "/api/v1/product_bundles/#{pb.id}", params: params, headers: headers

      # Assert
      expect(response.status).to eq 201
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["id"]).to be_a_kind_of(Integer)
      expect(parsed_response["name"]).to eq 'Kit Bruxaria'
      expect(parsed_response["product_bundle_items"][0]["product_model_id"]).to eq pm1.id
      expect(parsed_response["product_bundle_items"][1]["product_model_id"]).to eq pm3.id
      expect(parsed_response.keys).not_to include 'created_at'
      expect(parsed_response.keys).not_to include 'updated_at'
    end

    it "and can't edit" do
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
        name: 'Migalhas de pao', weight: 1000, height: 4, width: 17,
        length: 22, supplier: s, product_category: pc
      )
      pm2 = ProductModel.create!(
        name: 'Osso de Frango', weight: 1000, height: 4, width: 17,
        length: 22, supplier: s, product_category: pc
      )
      pm3 = ProductModel.create!(
        name: 'Doces', weight: 1000, height: 4, width: 17,
        length: 22, supplier: s, product_category: pc
      )
      pb = ProductBundle.create!(
        name: 'Kit Panos', product_model_ids:[pm1.id, pm2.id]
      )

      # Act
      headers = { "Content-Type " => "application/json"}
      params = { name: '' }
      put "/api/v1/product_bundles/#{pb.id}", params: params, headers: headers

      # Assert
      expect(response.status).to eq 422
      expect(response.body).to include "Nome não pode ficar em branco"
    end

    it "warehouse doesn't exist" do
      # Act
      put '/api/v1/product_bundles/999'

      # Assert
      expect(response.status).to eq 404
      expect(response.content_type).to include 'application/json'
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["error"]).to eq 'Objeto nao encontrado'
    end
  end
end
