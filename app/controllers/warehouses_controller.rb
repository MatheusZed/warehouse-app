class WarehousesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def show
    id = params[:id]
    @warehouse = Warehouse.find(id)
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
end
