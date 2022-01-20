FactoryBot.define do
  factory :warehouse do
    name { 'Osasco' }
    code { 'OZS' }
    description { 'Otimo galpao numa linda cidade com luzes' }
    address { 'Av Fernandes Lima' }
    city { 'Maceio' }
    state { 'AL' }
    postal_code { '57050-000' }
    total_area { 10_000 }
    useful_area { 8000 }
    product_category_ids { [association(:product_category)] }
  end
end