class WarehousesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :product_entry]
  before_action :set_warehouse, only: %i[show edit update]
  before_action :set_params, only: %i[create update]

  def show
    @product_models = ProductModel.all
    @items = @warehouse.product_items.group(:product_model).count
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    @warehouse = Warehouse.new(@warehouse_params)

    if @warehouse.save()
      #flash[:notice] = 'Galpao registrado com sucesso'
      redirect_to warehouse_path(@warehouse.id), notice: 'Successfully registered warehouse'
    else
      flash.now[:alert] = "It wasn't possible to record the warehouse"
      render 'new'
    end
  end

  def edit; end

  def update
    if @warehouse.update(@warehouse_params)
      redirect_to warehouse_path(@warehouse.id), notice: 'Successfully edited warehouse'
    else
      flash.now[:alert] = "It wasn't possible to edit the warehouse"
      render 'new'
    end
  end

  def product_entry
    @pe = ProductEntryService.new(quantity: params[:quantity], product_model_id: params[:product_model_id],
                                  warehouse_id: params[:id], sku: params[:sku])
    @product_models = ProductModel.all
    
    if @pe.process()
      redirect_to warehouse_path(@pe.warehouse_id), notice: 'Successfully registered items'
    else
      flash.now[:alert] = "It wasn't possible to record the items"
      render warehouse_path(@pe.warehouse_id), locals: { pe: @product_entry }
    end
  end


  private

  def set_warehouse
    @warehouse = Warehouse.find(params[:id])
  end

  def set_params
    @warehouse_params = params.require(:warehouse).permit(
      :name, :code, :description, :address, :state, :city,
      :postal_code, :total_area, :useful_area
    )
  end
end
