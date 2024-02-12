FactoryBot.define do
  factory :aquarium do
    name { "テスト水族館" }
    association :prefecture
    address { "東京都テスト区" }
    website { "http://example.com" }
  end
end
