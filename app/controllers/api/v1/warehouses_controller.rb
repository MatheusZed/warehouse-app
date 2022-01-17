class Api::V1::WarehousesController < Api::V1::ApiController
  def index
    warehouses = Warehouse.all
    render status: 200, json: warehouses.as_json(except: [:address, :created_at, :updated_at])
  end

  def show
    begin
      warehouse = Warehouse.find(params[:id])
      render status: 200, json: warehouse.as_json(except: [:address, :created_at, :updated_at])
    rescue ActiveRecord::RecordNotFound
      render json: '{}', status: 404
    end
  end
end
