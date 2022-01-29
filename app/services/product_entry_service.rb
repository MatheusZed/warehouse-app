class ProductEntryService
  include ActiveModel::Validations
  validate :quantity_must_be_greater_than_zero
  validate :validate_product_category
  validate :validate_inactive

  def initialize(quantity:, product_model_id:, warehouse_id:, sku:)
    @quantity = quantity.to_i
    @product_model_id = product_model_id
    @warehouse_id = warehouse_id
    @sku = sku
  end

  def process
    if valid?
      ProductItem.transaction do
        quantity.times do
          ProductItem.create!(warehouse: warehouse, product_model: product_model, sku: sku)
        end
      end
      true
    else
      false
    end
  end

  attr_reader :quantity, :product_model_id, :warehouse_id, :sku

  private

  def quantity_must_be_greater_than_zero
    errors.add(:base, 'Quantidade nao pode ser 0 ou menor') if quantity <= 0
  end

  def validate_product_category
    # rubocop:disable Style/GuardClause
    unless warehouse.product_categories.include? product_model.product_category
      errors.add(
        :base,
        'Nao foi possivel salvar estoque, '\
        'categoria de modelo de produto incompativel com categoria de galpao'
      )
    end
    # rubocop:enable Style/GuardClause
  end

  def validate_inactive
    errors.add(:base, 'Este modelo de produto está inativo') if product_model.inactive?
  end

  def warehouse
    @warehouse ||= Warehouse.find(warehouse_id)
  end

  def product_model
    @product_model ||= ProductModel.find(product_model_id)
  end
end
