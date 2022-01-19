class Warehouse < ApplicationRecord
  #Regras de negocio
  has_many :product_items
  has_many :product_category_warehouses
  has_many :product_categories, through: :product_category_warehouses
  validates :name, :code, :description, :address, :state, :city, 
            :postal_code, :total_area,:useful_area, presence: true
  validates :name, :code, uniqueness: true
  validates :postal_code, format: { with: /(^\d{5}-\d{3}$)/, message: "não é valido, formato: 00000-000"}
  validates :product_category_ids, length: { minimum: 1 , message: ": é necessario selecionar no minimo 1" }
end
