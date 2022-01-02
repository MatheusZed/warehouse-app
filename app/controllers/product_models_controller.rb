class ProductModelsController < ApplicationController
  def show
    id = params[:id]
    @pm = ProductModel.find(id)
  end

  def new
    @pm = ProductModel.new
    @sp = Supplier.all
  end

  def create
    product_model_params = params.require(:product_model).permit(:name, :weight, :height,
                                                                 :width, :length, :sku,
                                                                 :supplier_id)
    @pm = ProductModel.new(product_model_params)

    if @pm.save()
    redirect_to product_model_path(@pm.id), notice: 'Successfully registered product model'
    else
    flash.now[:alert] = "It wasn't possible to record the product model"
    render 'new'
    end
  end
end
