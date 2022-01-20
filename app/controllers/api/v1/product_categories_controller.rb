class Api::V1::ProductCategoriesController < Api::V1::ApiController
  before_action :set_product_category, only: %i[show update]
  before_action :set_params, only: %i[create update]

  def index
    product_categories = ProductCategory.all
    render status: 200, json: product_categories.as_json(except: %i[created_at updated_at])
  end

  def show
    render status: 200, json: @product_category.as_json(except: %i[created_at updated_at])
  end

  def create
    product_category = ProductCategory.new(@product_category_params)

    if product_category.save
      render status: 201, json: product_category.as_json(except: %i[created_at updated_at])
    else
      render status: 422, json: product_category.errors.full_messages
    end
  end

  def update
    if @product_category.update(@product_category_params)
      render status: 201, json: @product_category.as_json(except: %i[created_at updated_at])
    else
      render status: 422, json: @product_category.errors.full_messages
    end
  end

  private

  def set_product_category
    @product_category = ProductCategory.find(params[:id])
  end

  def set_params
    @product_category_params = params.permit(:name)
  end
end
