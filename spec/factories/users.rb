FactoryBot.define do
  factory :user do
    name { "test" }
    sequence :email do |n|
      "test#{n}@example.com"
    end
    password { "password" }
    password_confirmation { "password" }

    trait :admin do
      role { "admin" }
    end

    trait :general do
      role { "general" }
    end
  end
end
