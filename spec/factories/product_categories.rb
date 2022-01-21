FactoryBot.define do
  factory :product_category do
    sequence(:name) { |n| Faker::Creature::Animal.name + "#{n}" }
  end
end
