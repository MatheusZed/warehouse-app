class ProductCategory < ApplicationRecord
  has_many :product_models
  has_many :product_category_warehouses
  has_many :warehouses, through: :product_category_warehouses
  validates :name, presence: true
  validates :name, uniqueness: true
end
