class ProductEntryService
  include ActiveModel::Validations
  validate :quantity_must_be_greater_than_zero

  def initialize(quantity:, product_model_id:, warehouse_id:, sku:)
    @quantity = quantity.to_i
    @product_model_id = product_model_id
    @warehouse_id = warehouse_id
    @sku = sku
  end

  def process
    w = Warehouse.find(warehouse_id)
    pm = ProductModel.find(product_model_id)
    
    if valid?
      ProductItem.transaction do
        quantity.times do
          ProductItem.create!(warehouse: w, product_model: pm, sku: sku)
        end
      end
      true
    else
      false
    end
  end

  def quantity_must_be_greater_than_zero
    errors.add(:base, 'Quantidade nao pode ser 0 ou menor') if quantity <= 0
  end


  attr_reader :quantity, :product_model_id, :warehouse_id, :sku
end