class ProductItemsController < ApplicationController
  before_action :authenticate_user!, only: %i[process_entry new_entry]
  before_action :set_id, only: %i[process_entry]
  before_action :set_params, only: %i[process_entry]
  before_action :set_all, only: %i[new_entry process_entry]

  def new_entry
    @product_item = ProductItem.new
  end

  def process_entry
    if @warehouse.product_categories.include? @product_model.product_category
      if @product_entry.process()
        redirect_to warehouse_path(@product_entry.warehouse_id), notice: 'Successfully registered items'
      else
        flash.now[:alert] = "It wasn't possible to record the items"
        render 'new_entry', locals: { pe: @product_entry }
      end
    else
      flash.now[:alert] = "Nao foi possivel salvar estoque, categoria de modelo de produto incompativel com categoria de galpao"
      render 'new_entry', locals: { pe: @product_entry }
    end
  end


  private

  def set_id
    @warehouse = Warehouse.find(params[:warehouse_id])
    @product_model = ProductModel.find(params[:product_model_id])
  end

  def set_params
    @product_entry = ProductEntryService.new(
      quantity: params[:quantity], product_model_id: params[:product_model_id],
      warehouse_id: params[:warehouse_id], sku: params[:sku]
    )
  end

  def set_all
    @warehouses = Warehouse.all
    @product_models = ProductModel.all
  end
end