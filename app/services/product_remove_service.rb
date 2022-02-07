class ProductRemoveService
  include ActiveModel::Validations
  validate :quantity_must_be_greater_than_zero
  validate :quantity_must_be_less_than_item_size

  def initialize(quantity:, product_model_id:, warehouse_id:)
    @quantity = quantity.to_i
    @product_model_id = product_model_id
    @warehouse_id = warehouse_id
  end

  def process
    return false unless valid?

    ProductItem.transaction do
      find_product_items.last(quantity).each(&:destroy)
    end
    true
  end

  attr_reader :quantity, :product_model_id, :warehouse_id

  private

  def quantity_must_be_greater_than_zero
    errors.add(:base, 'Quantidade nao pode ser 0 ou menor') if quantity <= 0
  end

  def warehouse
    @warehouse ||= Warehouse.find(warehouse_id)
  end

  def product_model
    @product_model ||= ProductModel.find(product_model_id)
  end

  def find_product_items
    @find_product_items ||= ProductItem.where(
      product_model_id: product_model.id, warehouse_id: warehouse.id
    )
  end

  def product_items_size
    find_product_items.size
  end

  def quantity_must_be_less_than_item_size
    message = 'Quantidade nao pode ser maior que o numero de itens cadastrados'
    errors.add(:base, message) if quantity > product_items_size
  end
end
