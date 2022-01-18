class SuppliersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_supplier, only: %i[show edit update]
  before_action :set_params, only: %i[create update]

  def index
    @supplier = Supplier.all
  end

  def show
  end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(@supplier_params)

    if @supplier.save()
      redirect_to supplier_path(@supplier.id), notice: 'Successfully registered supplier'
    else
      flash.now[:alert] = "It wasn't possible to record the supplier"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @supplier.update(@supplier_params)
      redirect_to supplier_path(@supplier.id), notice: 'Successfully edited supplier'
    else
      flash.now[:alert] = "It wasn't possible to edit the supplier"
      render 'new'
    end
  end


  private

  def set_supplier
    @supplier = Supplier.find(params[:id])
  end

  def set_params
    @supplier_params = params.require(:supplier).permit(
      :fantasy_name, :legal_name,
      :cnpj, :address, :email, :phone
    )
  end
end
