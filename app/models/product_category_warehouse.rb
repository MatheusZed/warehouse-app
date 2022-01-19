class ProductCategoryWarehouse < ApplicationRecord
  belongs_to :product_category
  belongs_to :warehouse
end
