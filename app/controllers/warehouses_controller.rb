class WarehousesController < ApplicationController
  def show
    id = params[:id]
    @wh = Warehouse.find(id)
  end

  def new
    @wh = Warehouse.new
  end

  def create
    warehouse_params = params.require(:warehouse).permit(:name, :code, :description,
                                                         :address, :state, :city,
                                                         :postal_code, :total_area,
                                                         :useful_area)
    @wh = Warehouse.new(warehouse_params)
    @wh.save()
    #flash[:notice] = 'Galpao registrado com sucesso'
    redirect_to warehouse_path(@wh.id), notice: 'Galpao registrado com sucesso'
  end  
end
