class ProductCategory < ApplicationRecord
  has_many :product_models
  validates :name, presence: true
  validates :name, uniqueness: true
end
