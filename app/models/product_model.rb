class ProductModel < ApplicationRecord
  belongs_to :supplier
  validates :name, :weight, :height, :width, :length, :sku, presence: true
  validates :sku, uniqueness: true
  validates :weight, :height, :width, :length, numericality: { greater_than: 0 }

  def dimensions
    "#{height} x #{width} x #{length}"
  end
end
