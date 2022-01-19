class ProductItem < ApplicationRecord
  belongs_to :warehouse
  belongs_to :product_model
  validates :sku, presence: true
  validates :sku, uniqueness: true
  validates :sku, format: { with: /(^[A-Z]{3}.{17}$)/, message: "não é valido, precisa conter 20 digitos"}

  before_validation :generate_sku, on: :create

  private

  def generate_sku
    self.sku = "SKU#{SecureRandom.alphanumeric(17)}"
  end
end
