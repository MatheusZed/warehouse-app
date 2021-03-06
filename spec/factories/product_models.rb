FactoryBot.define do
  factory :product_model do
    name { Faker::JapaneseMedia::Naruto.character }
    weight { 1000  }
    height { 100 }
    width { 100 }
    length { 100 }
    status { 0 }
    supplier
    product_category
  end
end
