class Supplier < ApplicationRecord
  has_many  :product_models
  validates :fantasy_name, :legal_name, :cnpj, :email, presence: true
  validates :cnpj, uniqueness: true
  validates :cnpj, format: { with: /(^\d{2}\.?\d{3}\.?\d{3}\/?\d{4}\-?\d{2}$)/, message: "não é valido, precisa conter 14 digitos"}
end
