class ProductModelsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update]
  before_action :set_product_model, only: %i[show edit update activate]
  before_action :set_params, only: %i[create update]
  before_action :set_all, only: %i[new create edit update]

  def show
    @available_items = @product_model.product_items.group(:warehouse).count
  end

  def new
    @product_model = ProductModel.new
  end

  def create
    @product_model = ProductModel.new(@product_model_params)

    if @product_model.save
      redirect_to product_model_path(@product_model.id), notice: 'Successfully registered product model'
    else
      flash.now[:alert] = "It wasn't possible to record the product model"
      render 'new'
    end
  end

  def edit; end

  def update
    if @product_model.update(@product_model_params)
      redirect_to product_model_path(@product_model.id), notice: 'Successfully edited product model'
    else
      flash.now[:alert] = "It wasn't possible to edit the product model"
      render 'new'
    end
  end

  def activate
    if @product_model.active?
      @product_model.inactive!
      redirect_to product_model_path(@product_model.id), notice: 'O Modelo de Produto foi desativado com sucesso!'
    else
      @product_model.active!
      redirect_to product_model_path(@product_model.id), notice: 'O Modelo de Produto foi ativado com sucesso!'
    end
  end

  private

  def set_product_model
    @product_model = ProductModel.find(params[:id])
  end

  def set_params
    @product_model_params = params.require(:product_model).permit(
      :name, :weight, :height,
      :width, :length, :sku,
      :supplier_id, :product_category_id
    )
  end

  def set_all
    @supplier = Supplier.all
    @product_category = ProductCategory.all
  end
end
