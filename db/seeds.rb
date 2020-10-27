puts '== Seeding database =='

1000.times do |i|
  Apartment.create!(
    title: Forgery('name').full_name,
    price: SecureRandom.random_number(1000),
    sqm: SecureRandom.random_number(1000),
    number_of_bedrooms: SecureRandom.random_number(10),
    number_of_bathrooms: SecureRandom.random_number(3),
    picture: 'https://dywf8esi8sang.cloudfront.net/pictures/7b4b933a7b2d6d86a6742c94a0cf697a_large.jpg'
  )
end
