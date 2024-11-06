FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    price { Faker::Commerce.price }
    category { nil }
  end
end
