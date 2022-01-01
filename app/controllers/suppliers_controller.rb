class SuppliersController < ApplicationController
  def index
    @sp = Supplier.all
  end

  def show
    id = params[:id]
    @sp = Supplier.find(id)
  end

  def new
    @sp = Supplier.new
  end

  def create
    supplier_params = params.require(:supplier).permit(:fantasy_name, :legal_name,
                                                       :cnpj, :address, :email, :phone)
    @sp = Supplier.new(supplier_params)

    if @sp.save()
      redirect_to supplier_path(@sp.id), notice: 'Successfully registered supplier'
    else
      flash.now[:alert] = "It wasn't possible to record the supplier"
      render 'new'
    end
  end
end
