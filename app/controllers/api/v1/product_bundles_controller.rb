class Api::V1::ProductBundlesController < Api::V1::ApiController
  def index
    product_bundle = ProductBundle.all
    render status: 200, json: product_bundle.as_json(except:  [:created_at, :updated_at],
                                                     include: {product_bundle_items: {only: :product_model_id}})
  end

  def show
    begin
      product_bundle = ProductBundle.find(params[:id])
      render status: 200, json: product_bundle.as_json(except:  [:created_at, :updated_at],
                                                       include: {product_bundle_items: {only: :product_model_id}})
    rescue ActiveRecord::RecordNotFound
      render json: '{}', status: 404
    end
  end
end
