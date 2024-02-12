FactoryBot.define do
  factory :fish do
    name { Faker::Creature::Animal.name }
    selling_price_tanuki { Faker::Number.between(from: 100, to: 10000) }
    selling_price_justin { Faker::Number.between(from: 100, to: 10000) }
    image { Faker::Internet.url }
    association :location
  end
end
