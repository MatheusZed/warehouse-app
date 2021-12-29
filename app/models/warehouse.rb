class Warehouse < ApplicationRecord
  #Regras de negocio
  validates :name, :code, :description, :address, :state, :city, 
            :postal_code, :total_area,:useful_area, presence: true
end
