class Api::V1::ProductModelsController < Api::V1::ApiController
  def index
    product_models = ProductModel.all
    render status: 200, json: product_models.as_json(except:  [:created_at, :updated_at, :supplier_id, :product_category_id], 
                                                     methods: [:dimensions],
                                                     include: { supplier: { except: [:created_at, :updated_at, :cnpj, :address]},
                                                                product_category: { except: [:created_at, :updated_at]} })
  end

  def show
    product_models = ProductModel.find(params[:id])
    render status: 200, json: product_models.as_json(except:  [:created_at, :updated_at, :supplier_id, :product_category_id], 
                                                     methods: [:dimensions],
                                                     include: { supplier: { except: [:created_at, :updated_at, :cnpj, :address]},
                                                                product_category: { except: [:created_at, :updated_at]} })
  end

  def create
    product_model_params = params.permit(:name, :weight, :height, :width, :length, :supplier_id, :product_category_id)
    product_model = ProductModel.new(product_model_params)
    
    if product_model.save
      render status: 201, json: product_model.as_json(except: [:created_at, :updated_at])
    else
      render status: 422, json: product_model.errors.full_messages
    end
  end
end
