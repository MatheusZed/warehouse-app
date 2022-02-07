require 'rails_helper'

describe ProductRemoveService do
  let(:pm) { create(:product_model) }
  let(:wh) { create(:warehouse, product_categories: [pm.product_category]) }
  let(:service) { described_class.new(product_model_id: pm.id, warehouse_id: wh.id, quantity: quantity) }
  
  context '.process' do
    let(:quantity) { 4 }

    it 'works' do
      # Arrange
      create_list(:product_item, 5, warehouse: wh, product_model: pm)

      # act
      a = service.process
      product_items = ProductItem.where(
        product_model_id: pm.id, warehouse_id: wh.id
      )

      # assert
      expect(a).to be_truthy
      expect(product_items.size).to eq 1
    end
  end

  context 'error less than 0' do
    let(:quantity) { 0 }

    it 'does not work' do
      # act
      a = service.process

      # assert
      expect(a).to be_falsey
      expect(service.errors.size).to eq 1
    end
  end

  context 'error can not be greater than records size' do
    let(:quantity) { 10 }

    it 'does not work' do
      # Arrange
      create_list(:product_item, 5, warehouse: wh, product_model: pm)

      # act
      a = service.process

      # assert
      expect(a).to be_falsey
      expect(service.errors.size).to eq 1
    end
  end
end