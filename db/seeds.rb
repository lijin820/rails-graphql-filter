puts '== Seeding database =='

1000.times do |i|
  price = (SecureRandom.random_number(9e5) + 1e5).to_i
  sqm = rand(100...200)
  price_per_sqm = price / sqm
  pictures = [
    'https://dywf8esi8sang.cloudfront.net/pictures/167d5fac5616b0b550a15a228b33d7d2_large.jpg',
    'https://dywf8esi8sang.cloudfront.net/pictures/7b4b933a7b2d6d86a6742c94a0cf697a_large.jpg',
    'https://dywf8esi8sang.cloudfront.net/pictures/83ba40b3c59db20cdba886e7a35c1949_large.jpg',
    'https://dywf8esi8sang.cloudfront.net/pictures/fd873d5008a52abcdc24cc2418386729_large.jpg',
    'https://dywf8esi8sang.cloudfront.net/pictures/4a0f4cf917aed363dcaaeb7a055f18d4_large.jpg',
    'https://dywf8esi8sang.cloudfront.net/pictures/ce10598aaa95988113abe2c66cf7762a_large.jpg',
    'https://dywf8esi8sang.cloudfront.net/pictures/8d681df3182c5127279cfc2e2b0c900e_large.jpg',
    'https://dywf8esi8sang.cloudfront.net/pictures/022cab299a16bc482a4d9bc19fb17a7e_large.jpg',
    'https://dywf8esi8sang.cloudfront.net/pictures/7f552901f1bc6d7745ee3931f50704f9_large.jpg',
    'https://dywf8esi8sang.cloudfront.net/pictures/2719e7aabc1f6e0a6f8ad71ae95ee6a9_large.jpg',
    'https://dywf8esi8sang.cloudfront.net/pictures/a6486e4dae7c94b6a1d1a8521f9f536a_large.jpg',
    'https://dywf8esi8sang.cloudfront.net/pictures/e907f83f984adb66086b9384ec2bb1bb_large.jpg',
  ]
  Apartment.create!(
    title: Forgery('name').full_name,
    price: price,
    sqm: sqm,
    price_per_sqm: price_per_sqm,
    number_of_bedrooms: rand(1...10),
    number_of_bathrooms: rand(1...10),
    picture: pictures[rand(0..pictures.size)]
  )
end
