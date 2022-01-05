class SuppliersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
    @supplier = Supplier.all
  end

  def show
    id = params[:id]
    @supplier = Supplier.find(id)
  end

  def new
    @supplier = Supplier.new
  end

  def create
    supplier_params = params.require(:supplier).permit(:fantasy_name, :legal_name,
                                                       :cnpj, :address, :email, :phone)
    @supplier = Supplier.new(supplier_params)

    if @supplier.save()
      redirect_to supplier_path(@supplier.id), notice: 'Successfully registered supplier'
    else
      flash.now[:alert] = "It wasn't possible to record the supplier"
      render 'new'
    end
  end

  def edit
    id = params[:id]
    @supplier = Supplier.find(id)
  end

  def update
    id = params[:id]
    @supplier = Supplier.find(id)
    supplier_params = params.require(:supplier).permit(:fantasy_name, :legal_name,
                                                       :cnpj, :address, :email, :phone)

    if @supplier.update(supplier_params)
      redirect_to supplier_path(@supplier.id), notice: 'Successfully edited supplier'
    else
      flash.now[:alert] = "It wasn't possible to edit the supplier"
      render 'new'
    end
  end
end
