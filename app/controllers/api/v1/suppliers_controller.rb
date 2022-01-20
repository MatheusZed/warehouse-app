class Api::V1::SuppliersController < Api::V1::ApiController
  before_action :set_supplier, only: %i[show update]
  before_action :set_params, only: %i[create update]

  def index
    suppliers = Supplier.all
    render status: 200, json: suppliers.as_json(except: %i[created_at updated_at cnpj address])
  end

  def show
    render status: 200, json: @supplier.as_json(except: %i[created_at updated_at cnpj address])
  end

  def create
    supplier = Supplier.new(@supplier_params)

    if supplier.save
      render status: 201, json: supplier.as_json(except: %i[created_at updated_at])
    else
      render status: 422, json: supplier.errors.full_messages
    end
  end

  def update
    if @supplier.update(@supplier_params)
      render status: 201, json: @supplier.as_json(except: %i[created_at updated_at])
    else
      render status: 422, json: @supplier.errors.full_messages
    end
  end

  private

  def set_supplier
    @supplier = Supplier.find(params[:id])
  end

  def set_params
    @supplier_params = params.permit(
      :fantasy_name, :legal_name, :cnpj,
      :address, :email, :phone
    )
  end
end
