class ProductModelsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  
  def show
    id = params[:id]
    @product_model = ProductModel.find(id)
  end

  def new
    @product_model = ProductModel.new
    @supplier = Supplier.all
    @product_category = ProductCategory.all
  end

  def create
    product_model_params = params.require(:product_model).permit(:name, :weight, :height,
                                                                 :width, :length, :sku,
                                                                 :supplier_id, :product_category_id)
    @product_model = ProductModel.new(product_model_params)
    @supplier = Supplier.all
    @product_category = ProductCategory.all

    if @product_model.save()
    redirect_to product_model_path(@product_model.id), notice: 'Successfully registered product model'
    else
    flash.now[:alert] = "It wasn't possible to record the product model"
    render 'new'
    end
  end

  def edit
    id = params[:id]
    @product_model = ProductModel.find(id)
    @supplier = Supplier.all
    @product_category = ProductCategory.all
  end

  def update
    id = params[:id]
    @product_model = ProductModel.find(id)
    @supplier = Supplier.all
    @product_category = ProductCategory.all
    product_model_params = params.require(:product_model).permit(:name, :weight, :height,
                                                                 :width, :length, :sku,
                                                                 :supplier_id, :product_category_id)

    if @product_model.update(product_model_params)
      redirect_to product_model_path(@product_model.id), notice: 'Successfully edited product model'
    else
      flash.now[:alert] = "It wasn't possible to edit the product model"
      render 'new'
    end
  end
end
