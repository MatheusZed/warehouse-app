class Api::V1::ProductCategoriesController < Api::V1::ApiController
  def index
    product_category = ProductCategory.all
    render status: 200, json: product_category.as_json(except: [:created_at, :updated_at])
  end

  def show
    begin
      product_category = ProductCategory.find(params[:id])
      render status: 200, json: product_category.as_json(except: [:created_at, :updated_at])
    rescue ActiveRecord::RecordNotFound
      render json: '{}', status: 404
    end
  end
end
