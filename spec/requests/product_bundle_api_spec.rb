require 'rails_helper'

describe 'Product Bundle API' do
  context 'GET api/v1/product_bundles' do
    it 'successfuly' do
      # Arrange
      s = Supplier.create!(fantasy_name: 'Maria', legal_name: 'Maria e os doces',
                           cnpj: '22416076000136', address: 'Rua Benedito Spinardi',
                           email: 'maria.doceria@yahoo.com', phone: '91124-2855')
      pc = ProductCategory.create!(name: 'Conservados')
      pm1 = ProductModel.create!(name: 'Migalhas de pao', weight: 1000, height: 4, width: 17,
                                 length: 22, supplier: s, product_category: pc)
      pm2 = ProductModel.create!(name: 'Osso de Frango', weight: 1000, height: 4, width: 17,
                                 length: 22, supplier: s, product_category: pc)
      pm3 = ProductModel.create!(name: 'Doces', weight: 1000, height: 4, width: 17,
                                 length: 22, supplier: s, product_category: pc)
      pb1 = ProductBundle.create!(name: 'Kit Bruxaria')
      pb2 = ProductBundle.create!(name: 'Kit Xariabru')
      ProductBundleItem.create!(product_bundle: pb1, product_model: pm1)
      ProductBundleItem.create!(product_bundle: pb1, product_model: pm2)
      ProductBundleItem.create!(product_bundle: pb1, product_model: pm3)
      ProductBundleItem.create!(product_bundle: pb2, product_model: pm1)
      ProductBundleItem.create!(product_bundle: pb2, product_model: pm3)

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
      s = Supplier.create!(fantasy_name: 'Maria', legal_name: 'Maria e os doces',
                           cnpj: '22416076000136', address: 'Rua Benedito Spinardi',
                           email: 'maria.doceria@yahoo.com', phone: '91124-2855')
      pc = ProductCategory.create!(name: 'Conservados')
      pm1 = ProductModel.create!(name: 'Migalhas de pao', weight: 1000, height: 4, width: 17,
                                 length: 22, supplier: s, product_category: pc)
      pm2 = ProductModel.create!(name: 'Osso de Frango', weight: 1000, height: 4, width: 17,
                                 length: 22, supplier: s, product_category: pc)
      pm3 = ProductModel.create!(name: 'Doces', weight: 1000, height: 4, width: 17,
                                 length: 22, supplier: s, product_category: pc)
      pb1 = ProductBundle.create!(name: 'Kit Bruxaria')
      ProductBundleItem.create!(product_bundle: pb1, product_model: pm1)
      ProductBundleItem.create!(product_bundle: pb1, product_model: pm2)
      ProductBundleItem.create!(product_bundle: pb1, product_model: pm3)

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
    end
  end
end
