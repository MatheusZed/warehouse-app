class WarehousesController < ApplicationController
  def show
    id = params[:id]
    @wh = Warehouse.find(id)
  end
end
