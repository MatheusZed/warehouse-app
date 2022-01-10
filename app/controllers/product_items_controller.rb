class ProductItemsController < ApplicationController
  before_action :authenticate_user!, only: [:process_entry, :new_entry]

  def new_entry
    @warehouses = Warehouse.all
    @product_models = ProductModel.all
  end

  def process_entry
    quantity = params[:quantity].to_i
    warehouse_id = params[:warehouse_id]
    product_model_id = params[:product_model_id]
    sku = params[:sku]
    
    w = Warehouse.find(warehouse_id)
    pm = ProductModel.find(product_model_id)
    
    quantity.times do
      m = ProductItem.create!(warehouse: w, product_model: pm , sku: sku)
    end    

    redirect_to w
  end
end