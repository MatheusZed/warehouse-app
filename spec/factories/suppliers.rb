FactoryBot.define do
  factory :supplier do
    fantasy_name { Faker::Games::Pokemon.name }
    legal_name { Faker::TvShows::SouthPark.character  }
    cnpj { rand.to_s[2..15] }
    address { Faker::Address.street_address }
    email { Faker::Internet.email }
    phone { '91124-2855' }
  end
end
