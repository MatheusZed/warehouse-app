class ProductItemsController < ApplicationController
  before_action :authenticate_user!, only: [:process_entry, :new_entry]

  def new_entry
    @product_item = ProductItem.new
    @warehouses = Warehouse.all
    @product_models = ProductModel.all
  end

  def process_entry
    @product_entry = ProductEntryService.new(quantity: params[:quantity], product_model_id: params[:product_model_id],
                                             warehouse_id: params[:warehouse_id], sku: params[:sku])
    @warehouses = Warehouse.all
    @product_models = ProductModel.all

    if @product_entry.process()
      redirect_to warehouse_path(@product_entry.warehouse_id), notice: 'Successfully registered items'
    else
      flash.now[:alert] = "It wasn't possible to record the items"
      render 'new_entry', locals: { pe: @product_entry }
    end
  end
end