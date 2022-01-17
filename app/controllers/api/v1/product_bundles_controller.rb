class Api::V1::ProductBundlesController < Api::V1::ApiController
  def index
    product_bundle = ProductBundle.all
    render status: 200, json: product_bundle.as_json(except:  [:created_at, :updated_at],
                                                     include: {product_bundle_items: {only: :product_model_id}})
  end

  def show
    product_bundle = ProductBundle.find(params[:id])
    render status: 200, json: product_bundle.as_json(except:  [:created_at, :updated_at],
                                                     include: {product_bundle_items: {only: :product_model_id}})
  end

  def create
    product_bundle_params = params.permit(:name, product_model_ids: [])
    product_bundle = ProductBundle.new(product_bundle_params)
    
    if product_bundle.save
      render status: 201, json: product_bundle.as_json(except: [:created_at, :updated_at],
                                                       include: {product_bundle_items: {only: :product_model_id}})
    else
      render status: 422, json: product_bundle.errors.full_messages
    end
  end
end
