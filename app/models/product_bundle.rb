class ProductBundle < ApplicationRecord
  has_many :product_bundle_items
  has_many :product_models, through: :product_bundle_items
  validates :name, :sku, presence: true
  validates :name, :sku, uniqueness: true
  validates :sku, format: { with: /(^[A-Z]{4}.{17}$)/, message: "não é valido, precisa conter 21 digitos"}

  before_validation :generate_ksku

  private
  
  def generate_ksku
    self.sku = "KSKU#{SecureRandom.alphanumeric(17)}"
  end
end
