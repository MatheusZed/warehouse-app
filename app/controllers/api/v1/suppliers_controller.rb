class Api::V1::SuppliersController < Api::V1::ApiController
  def index
    suppliers = Supplier.all
    render status: 200, json: suppliers.as_json(except: [:created_at, :updated_at, :cnpj, :address])
  end

  def show
    supplier = Supplier.find(params[:id])
    render status: 200, json: supplier.as_json(except: [:created_at, :updated_at, :cnpj, :address])
  end
end
