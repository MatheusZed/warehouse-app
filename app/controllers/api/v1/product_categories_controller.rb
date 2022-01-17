class Api::V1::ProductCategoriesController < Api::V1::ApiController
  def index
    product_category = ProductCategory.all
    render status: 200, json: product_category.as_json(except: [:created_at, :updated_at])
  end

  def show
    product_category = ProductCategory.find(params[:id])
    render status: 200, json: product_category.as_json(except: [:created_at, :updated_at])
  end

  def create
    product_category_params = params.permit(:name)
    product_category = ProductCategory.new(product_category_params)
    
    if product_category.save
      render status: 201, json: product_category.as_json(except: [:created_at, :updated_at])
    else
      render status: 422, json: product_category.errors.full_messages
    end
  end
end
