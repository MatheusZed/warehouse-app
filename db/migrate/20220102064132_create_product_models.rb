class CreateProductModels < ActiveRecord::Migration[6.1]
  def change
    create_table :product_models do |t|
      t.string :name
      t.integer :weight
      t.integer :height
      t.integer :width
      t.integer :length
      t.references :supplier, null: false, foreign_key: true
      t.string :sku

      t.timestamps
    end
  end
end
