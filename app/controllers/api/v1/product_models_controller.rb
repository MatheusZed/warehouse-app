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
end
