class ProductCategoriesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
    @product_category = ProductCategory.all
  end

  def show
    id = params[:id]
    @product_category = ProductCategory.find(id)
  end

  def new
    @product_category = ProductCategory.new
  end

  def create
    product_category_params = params.require(:product_category).permit(:name)
    @product_category = ProductCategory.new(product_category_params)

    if @product_category.save()
      redirect_to product_categories_path, notice: 'Successfully registered product category'
      else
      flash.now[:alert] = "It wasn't possible to record the product category"
      render 'new'
    end
  end

  def edit
    id = params[:id]
    @product_category = ProductCategory.find(id)
  end

  def update
    id = params[:id]
    @product_category = ProductCategory.find(id)
    product_category_params = params.require(:product_category).permit(:name)

    if @product_category.update(product_category_params)
      redirect_to product_categories_path, notice: 'Successfully edited product category'
    else
      flash.now[:alert] = "It wasn't possible to edit the product category"
      render 'new'
    end
  end
end
