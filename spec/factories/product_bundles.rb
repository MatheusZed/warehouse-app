FactoryBot.define do
  factory :product_bundle do
    name { Faker::Coffee.blend_name }
  end
end
