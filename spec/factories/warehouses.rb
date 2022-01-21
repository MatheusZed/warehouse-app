FactoryBot.define do
  factory :warehouse do
    name { Faker::Movies::HarryPotter.character }
    code { Faker::Music.band }
    description { Faker::Movies::HarryPotter.quote }
    address { Faker::Movies::HarryPotter.location }
    city { Faker::Movies::HarryPotter.house }
    state { Faker::Movies::HarryPotter.spell}
    postal_code { '57050-000' }
    total_area { 10_000 }
    useful_area { 8000 }
  end
end
