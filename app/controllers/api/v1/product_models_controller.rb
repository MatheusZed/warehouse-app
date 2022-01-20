class Api::V1::ProductModelsController < Api::V1::ApiController
  before_action :set_product_model, only: %i[show update]
  before_action :set_params, only: %i[create update]

  def index
    product_models = ProductModel.all
    render status: 200, json: product_models.as_json(
      except: %i[created_at updated_at supplier_id product_category_id],
      methods: [:dimensions],
      include: { supplier: { except: %i[created_at updated_at cnpj address] },
                 product_category: { except: %i[created_at updated_at] } }
    )
  end

  def show
    render status: 200, json: @product_model.as_json(
      except: %i[created_at updated_at supplier_id product_category_id],
      methods: [:dimensions],
      include: { supplier: { except: %i[created_at updated_at cnpj address] },
                 product_category: { except: %i[created_at updated_at] } }
    )
  end

  def create
    product_model = ProductModel.new(@product_model_params)

    if product_model.save
      render status: 201, json: product_model.as_json(except: %i[created_at updated_at])
    else
      render status: 422, json: product_model.errors.full_messages
    end
  end

  def update
    if @product_model.update(@product_model_params)
      render status: 201, json: @product_model.as_json(except: %i[created_at updated_at])
    else
      render status: 422, json: @product_model.errors.full_messages
    end
  end

  private

  def set_product_model
    @product_model = ProductModel.find(params[:id])
  end

  def set_params
    @product_model_params = params.permit(
      :name, :weight, :height, :width,
      :length, :supplier_id, :product_category_id
    )
  end
end
