class Api::V1::WarehousesController < Api::V1::ApiController
  before_action :set_warehouse, only: %i[show update]
  before_action :set_params, only: %i[create update]

  def index
    warehouses = Warehouse.all
    render status: 200, json: warehouses.as_json(
      except: [:address, :created_at, :updated_at],
      include: {product_category_warehouses: {only: :product_category_id}}
    )
  end

  def show
    render status: 200, json: @warehouse.as_json(
      except: [:address, :created_at, :updated_at],
      include: {product_category_warehouses: {only: :product_category_id}}
    )
  end

  def create
    warehouse = Warehouse.new(@warehouse_params)

    if warehouse.save
      render status: 201, json: warehouse.as_json(
        except: [:created_at, :updated_at],
        include: {product_category_warehouses: {only: :product_category_id}}
      ) 
    else
      render status: 422, json: warehouse.errors.full_messages
    end
  end

  def update
    if @warehouse.update(@warehouse_params)
      render status: 201, json: @warehouse.as_json(
        except: [:created_at, :updated_at],
        include: {product_category_warehouses: {only: :product_category_id}}
      )
    else
      render status: 422, json: @warehouse.errors.full_messages
    end
  end


  private

  def set_warehouse
    @warehouse = Warehouse.find(params[:id])
  end
  
  def set_params
    @warehouse_params = params.permit(
      :name, :code, :description, :address, :city, :state, :postal_code,
      :total_area, :useful_area, product_category_ids: []
    )  
  end
end
