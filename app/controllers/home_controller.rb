class HomeController < ApplicationController
  def index
    @warehouse = Warehouse.all    
  end

  def search
    @warehouses = Warehouse.where('name like ? OR code like ?',
                                  "%#{params[:q]}%", "%#{params[:q]}%")
  end
end
