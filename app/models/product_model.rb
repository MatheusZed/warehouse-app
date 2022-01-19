class ProductModel < ApplicationRecord
  belongs_to :supplier
  belongs_to :product_category
  has_many :product_items
  has_many :product_bundle_items
  has_many :product_bundles, through: :product_bundle_items
  validates :name, :weight, :height, :width, :length, :sku, presence: true
  validates :sku, uniqueness: true
  validates :weight, :height, :width, :length, numericality: { greater_than: 0 }
  validates :sku, format: { with: /(^[A-Z]{3}.{17}$)/, message: "não é valido, precisa conter 20 digitos"}

  before_validation :generate_sku, on: :create

  def dimensions
    "#{height} x #{width} x #{length}"
  end

  private

  def generate_sku
    self.sku = "SKU#{SecureRandom.alphanumeric(17)}"
  end
end
