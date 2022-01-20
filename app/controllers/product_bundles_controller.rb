class ProductBundlesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update]
  before_action :set_product_bundle, only: %i[show edit update]
  before_action :set_params, only: %i[create update]
  before_action :set_all, only: %i[new create edit update]

  def show; end

  def new
    @product_bundle = ProductBundle.new
  end

  def create
    @product_bundle = ProductBundle.new(@product_bundle_params)

    if @product_bundle.save
      redirect_to product_bundle_path(@product_bundle.id), notice: 'Successfully registered product bundle'
    else
      flash.now[:alert] = "It wasn't possible to record the product bundle"
      render 'new'
    end
  end

  def edit; end

  def update
    if @product_bundle.update(@product_bundle_params)
      redirect_to product_bundle_path(@product_bundle.id), notice: 'Successfully edited product bundle'
    else
      flash.now[:alert] = "It wasn't possible to edit the product bundle"
      render 'new'
    end
  end

  private

  def set_product_bundle
    @product_bundle = ProductBundle.find(params[:id])
  end

  def set_params
    @product_bundle_params = params.require(:product_bundle).permit(
      :name, :sku, product_model_ids: []
    )
  end

  def set_all
    @product_models = ProductModel.all
  end
end
