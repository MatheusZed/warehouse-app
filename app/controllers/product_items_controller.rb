class ProductItemsController < ApplicationController
  before_action :authenticate_user!, only: [:process_entry, :new_entry]

  def new_entry
    @product_item = ProductItem.new
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
    @pi = ProductItem.new(warehouse: w, product_model: pm , sku: sku)
    quantity = quantity - 1
    
    if quantity > 0
      if @pi.save()
      quantity.times do
        m = ProductItem.create!(warehouse: w, product_model: pm , sku: sku)
      end

      redirect_to w, notice: 'Successfully registered items'
      end
    else
    flash.now[:alert] = "It wasn't possible to record the items"
    render 'new_entry'
    end
  end
end