class Api::V1::SuppliersController < Api::V1::ApiController
  def index
    suppliers = Supplier.all
    render status: 200, json: suppliers.as_json(except: [:created_at, :updated_at, :cnpj, :address])
  end

  def show
    supplier = Supplier.find(params[:id])
    render status: 200, json: supplier.as_json(except: [:created_at, :updated_at, :cnpj, :address])
  end

  def create
    supplier_params = params.permit(:fantasy_name, :legal_name, :cnpj, :address, :email, :phone)
    supplier = Supplier.new(supplier_params)
    
    if supplier.save
      render status: 201, json: supplier.as_json(except: [:created_at, :updated_at])
    else
      render status: 422, json: supplier.errors.full_messages
    end
  end
end
