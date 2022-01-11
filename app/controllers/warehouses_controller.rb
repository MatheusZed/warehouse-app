class WarehousesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def show
    id = params[:id]
    @warehouse = Warehouse.find(id)
    @product_models = ProductModel.all
    @items = @warehouse.product_items.group(:product_model).count
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    warehouse_params = params.require(:warehouse).permit(:name, :code, :description,
                                                         :address, :state, :city,
                                                         :postal_code, :total_area,
                                                         :useful_area)
    @warehouse = Warehouse.new(warehouse_params)

    if @warehouse.save()
    #flash[:notice] = 'Galpao registrado com sucesso'
      redirect_to warehouse_path(@warehouse.id), notice: 'Successfully registered warehouse'
    else
      flash.now[:alert] = "It wasn't possible to record the warehouse"
      render 'new'
    end
  end

  def edit
    id = params[:id]
    @warehouse = Warehouse.find(id)
  end

  def update
    id = params[:id]
    @warehouse = Warehouse.find(id)
    warehouse_params = params.require(:warehouse).permit(:name, :code, :description,
                                                         :address, :state, :city,
                                                         :postal_code, :total_area,
                                                         :useful_area)

    if @warehouse.update(warehouse_params)
      redirect_to warehouse_path(@warehouse.id), notice: 'Successfully edited warehouse'
      else
        flash.now[:alert] = "It wasn't possible to edit the warehouse"
        render 'new'
    end
  end

  def product_entry
    warehouse_id = params[:id]
    quantity = params[:quantity].to_i
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
