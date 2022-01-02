class ProductModel < ApplicationRecord
  belongs_to :supplier

  def dimensions
    "#{height} x #{width} x #{length}"
  end
end
