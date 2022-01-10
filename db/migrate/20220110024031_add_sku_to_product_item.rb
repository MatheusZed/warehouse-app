class AddSkuToProductItem < ActiveRecord::Migration[6.1]
  def change
    add_column :product_items, :sku, :string
  end
end
