class ProductBundlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  
  def show
    id = params[:id]
    @pb = ProductBundle.find(id)
  end

  def new
    @pb = ProductBundle.new
  end

  def create
    bundle_params = params.require(:product_bundle).permit(:name, :sku, product_model_ids: [])
    @pb = ProductBundle.new(bundle_params)

    if @pb.save()
      redirect_to product_bundle_path(@pb.id), notice: 'Successfully registered product bundle'
      else
      flash.now[:alert] = "It wasn't possible to record the product bundle"
      render 'new'
    end
  end
end