class CreateProductCategoryWarehouses < ActiveRecord::Migration[6.1]
  def change
    create_table :product_category_warehouses do |t|
      t.references :product_category, null: false, foreign_key: true
      t.references :warehouse, null: false, foreign_key: true

      t.timestamps
    end
  end
end
