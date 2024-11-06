FactoryBot.define do
  factory :link do
    url { Faker::Internet.url }
    scraper { "hardvisionlr" }
    isActive { Faker::Boolean.boolean }
    category { nil }
  end
end
