class AddProductCategoryToProductModel < ActiveRecord::Migration[6.1]
  def change
    add_reference :product_models, :product_category, null: false, foreign_key: true, default: 0
  end
end
