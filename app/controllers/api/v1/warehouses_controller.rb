class Api::V1::WarehousesController < Api::V1::ApiController
  def index
    warehouses = Warehouse.all
    render status: 200, json: warehouses.as_json(except: [:address, :created_at, :updated_at])
  end

  def show
    warehouse = Warehouse.find(params[:id])
    render status: 200, json: warehouse.as_json(except: [:address, :created_at, :updated_at])
  end

  def create
    warehouse_params = params.permit(:name, :code, :description, :address, :city, :state,
                                     :postal_code, :total_area, :useful_area)
    warehouse = Warehouse.new(warehouse_params)
    
    if warehouse.save
      render status: 201, json: warehouse
    else
      render status: 422, json: warehouse.errors.full_messages
    end
  end
end
