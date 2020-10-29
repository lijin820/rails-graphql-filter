puts '== Seeding database =='

1000.times do |i|
  price = (SecureRandom.random_number(9e5) + 1e5).to_i
  sqm = rand(100...200)
  price_per_sqm = price / sqm
  Apartment.create!(
    title: Forgery('name').full_name,
    price: price,
    sqm: sqm,
    price_per_sqm: price_per_sqm,
    number_of_bedrooms: SecureRandom.random_number(10),
    number_of_bathrooms: SecureRandom.random_number(3),
    picture: 'https://dywf8esi8sang.cloudfront.net/pictures/7b4b933a7b2d6d86a6742c94a0cf697a_large.jpg'
  )
end
