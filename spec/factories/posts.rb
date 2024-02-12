FactoryBot.define do
  factory :post do
    sequence(:user_id) { |n| n }
    sequence(:fish_id) { |n| n }
    sequence(:aquarium_id) { |n| n }    
    post_image { 
      Rack::Test::UploadedFile.new(
        Rails.root.join('spec', 'fixtures', 'files', 'example.jpg'), 'image/jpeg'
      )
    }
    shooting_date { Date.today }
    body { "This is a test post." }
  end
end
