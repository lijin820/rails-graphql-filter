FactoryBot.define do
  factory :apartment do
    sequence(:title) { |i| "Title #{i}" }
    sequence(:price) { |i| i * 1000 }
    sequence(:sqm) { |i| i * 1000 }
    sequence(:number_of_bedrooms) { |i| i * 10 }
    sequence(:number_of_bathrooms) { |i| i * 10 }
    sequence(:picture) { "https://dywf8esi8sang.cloudfront.net/pictures/7b4b933a7b2d6d86a6742c94a0cf697a_large.jpg" }
  end
end
