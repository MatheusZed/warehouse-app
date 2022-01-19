class ProductBundle < ApplicationRecord
  has_many :product_bundle_items
  has_many :product_models, through: :product_bundle_items
  validates :name, :sku, presence: true
  validates :name, :sku, uniqueness: true
  validates :sku, format: { with: /(^[A-Z]{4}.{17}$)/, message: "não é valido, precisa conter 21 digitos"}
  validates :product_model_ids, length: { minimum: 2 , message: ": é necessario selecionar no minimo 2" }

  before_validation :generate_ksku, on: :create

  private
  
  def generate_ksku
    self.sku = "KSKU#{SecureRandom.alphanumeric(17)}"
  end
end
