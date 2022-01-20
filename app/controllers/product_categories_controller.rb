class ProductCategoriesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update]
  before_action :set_product_category, only: %i[show edit update]
  before_action :set_params, only: %i[create update]

  def index
    @product_category = ProductCategory.all
  end

  def show; end

  def new
    @product_category = ProductCategory.new
  end

  def create
    @product_category = ProductCategory.new(@product_category_params)

    if @product_category.save
      redirect_to product_categories_path, notice: 'Successfully registered product category'
    else
      flash.now[:alert] = "It wasn't possible to record the product category"
      render 'new'
    end
  end

  def edit; end

  def update
    if @product_category.update(@product_category_params)
      redirect_to product_categories_path, notice: 'Successfully edited product category'
    else
      flash.now[:alert] = "It wasn't possible to edit the product category"
      render 'new'
    end
  end

  private

  def set_product_category
    @product_category = ProductCategory.find(params[:id])
  end

  def set_params
    @product_category_params = params.require(:product_category).permit(:name)
  end
end
