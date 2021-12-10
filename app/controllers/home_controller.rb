class HomeController < ApplicationController
  def index
    @wh = Warehouse.all
    
  end
end