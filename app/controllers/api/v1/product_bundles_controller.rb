class Api::V1::ProductBundlesController < Api::V1::ApiController
  before_action :set_product_bundle, only: %i[show update]
  before_action :set_params, only: %i[create update]

  def index
    product_bundles = ProductBundle.all
    render status: 200, json: product_bundles.as_json(
      except: %i[created_at updated_at],
      include: { product_bundle_items: { only: :product_model_id } }
    )
  end

  def show
    render status: 200, json: @product_bundle.as_json(
      except: %i[created_at updated_at],
      include: { product_bundle_items: { only: :product_model_id } }
    )
  end

  def create
    product_bundle = ProductBundle.new(@product_bundle_params)

    if product_bundle.save
      render status: 201, json: product_bundle.as_json(
        except: %i[created_at updated_at],
        include: { product_bundle_items: { only: :product_model_id } }
      )
    else
      render status: 422, json: product_bundle.errors.full_messages
    end
  end

  def update
    if @product_bundle.update(@product_bundle_params)
      render status: 201, json: @product_bundle.as_json(
        except: %i[created_at updated_at],
        include: { product_bundle_items: { only: :product_model_id } }
      )
    else
      render status: 422, json: @product_bundle.errors.full_messages
    end
  end

  private

  def set_product_bundle
    @product_bundle = ProductBundle.find(params[:id])
  end

  def set_params
    @product_bundle_params = params.permit(:name, product_model_ids: [])
  end
end
