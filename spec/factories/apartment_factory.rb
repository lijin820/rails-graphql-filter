FactoryBot.define do
  factory :apartment do
    sequence(:name) { |n| "Apartment (#{n})" }
  end
end
