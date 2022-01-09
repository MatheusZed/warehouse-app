class ProductBundlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  
  def show
    id = params[:id]
    @product_bundle = ProductBundle.find(id)
  end

  def new
    @product_bundle = ProductBundle.new
    @supplier = Supplier.all
  end

  def create
    bundle_params = params.require(:product_bundle).permit(:name, :sku, product_model_ids: [])
    @product_bundle = ProductBundle.new(bundle_params)

    if @product_bundle.save()
      redirect_to product_bundle_path(@product_bundle.id), notice: 'Successfully registered product bundle'
      else
      flash.now[:alert] = "It wasn't possible to record the product bundle"
      render 'new'
    end
  end

  def edit
    id = params[:id]
    @product_bundle = ProductBundle.find(id)
  end

  def update
    id = params[:id]
    @product_bundle = ProductBundle.find(id)
    product_bundle_params = params.require(:product_bundle).permit(:name, :sku, product_model_ids: [])

    if @product_bundle.update(product_bundle_params)
      redirect_to product_bundle_path(@product_bundle.id), notice: 'Successfully edited product bundle'
    else
      flash.now[:alert] = "It wasn't possible to edit the product bundle"
      render 'new'
    end
  end
end