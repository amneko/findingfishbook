FactoryBot.define do
  factory :post do
    association :user
    association :fish
    association :aquarium
    post_image { Rack::Test::UploadedFile.new('/Users/aina/Downloads/fish_52.JPG', 'image/jpeg') }
    shooting_date { Date.today }
    body { "This is a test post." }
  end
end
