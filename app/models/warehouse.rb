class Warehouse < ApplicationRecord
  #Regras de negocio
  validates :name, :code, :description, :address, :state, :city, 
            :postal_code, :total_area,:useful_area, presence: true
  validates :name, :code, uniqueness: true
  validates :postal_code, format: { with: /(^\d{5}-\d{3}$)/, message: "não é valido, formato: 00000-000"}
end
