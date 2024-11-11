FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password123" }
    role { "User" }

    trait :admin do
      role { "Admin" }
    end
  end
end