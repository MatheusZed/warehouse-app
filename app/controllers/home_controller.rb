class HomeController < ApplicationController
  def index
    @warehouse = Warehouse.all    
  end
end
