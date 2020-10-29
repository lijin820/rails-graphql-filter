require 'test_helper'

class Resolvers::ApartmentSearchTest < ActiveSupport::TestCase
  def find(args)
    Resolvers::ApartmentSearch.call(nil, args, nil)
  end

  test 'offset option' do
    apartment = create(:apartment, title: 'old')
    create(:apartment, title: 'new')

    assert_equal(find(offset: 1), [apartment])
  end

  test 'limit option' do
    create(:apartment, title: 'old')
    apartment = create(:apartment, title: 'new')

    assert_equal(find(limit: 1), [apartment])
  end

  test 'filter option' do
    apartment1 = create(:apartment, title: 'test1')
    apartment2 = create(:apartment, title: 'test2')
    apartment3 = create(:apartment, title: 'test3')
    create(:apartment, title: 'test4')

    result = find(
      filter: {
        title_contains: 'test1',
        OR: [{
          title_contains: 'test2',
          OR: [{
            title_contains: 'test3'
          }]
        }, {
          title_contains: 'test2'
        }]
      }
    )

    assert_equal(result.map(&:title).sort, [apartment1, apartment2, apartment3].map(&:title).sort)
  end

  test 'order by createdAt_ASC' do
    new = create(:apartment, created_at: 1.week.ago)
    old = create(:apartment, created_at: 1.month.ago)

    assert_equal(find(orderBy: 'createdAt_ASC'), [old, new])
  end

  test 'order by createdAt_DESC' do
    new = create(:apartment, created_at: 1.week.ago)
    old = create(:apartment, created_at: 1.month.ago)

    assert_equal(find(orderBy: 'createdAt_DESC'), [new, old])
  end

  test 'case one for range filter with price_gte and price_lte' do
    apartment1 = create(:apartment, price: 15000)
    apartment2 = create(:apartment, price: 12000)
    apartment3 = create(:apartment, price: 25000)

    result = find(
      filter: {
        price_gte: 22000,
        price_lte: 30000,
      }
    )

    assert_equal(result.map(&:title).sort, [apartment3].map(&:title).sort)
  end

  test 'case two for range filter with price_gte and price_lte' do
    apartment1 = create(:apartment, price: 15000)
    apartment2 = create(:apartment, price: 12000)
    apartment3 = create(:apartment, price: 25000)

    result = find(
      filter: {
        price_gte: 10000,
        price_lte: 16000,
      }
    )

    assert_equal(result.map(&:title).sort, [apartment1, apartment2].map(&:title).sort)
  end

  test 'case three for range filter with price_gte and price_lte' do
    apartment1 = create(:apartment, price: 15000)
    apartment2 = create(:apartment, price: 12000)
    apartment3 = create(:apartment, price: 25000)

    result = find(
      filter: {
        price_gte: 10000,
      }
    )

    assert_equal(result.map(&:title).sort, [apartment1, apartment2, apartment3].map(&:title).sort)
  end

  test 'case one for range filter with sqm_gte and sqm_lte' do
    apartment1 = create(:apartment, sqm: 150)
    apartment2 = create(:apartment, sqm: 120)
    apartment3 = create(:apartment, sqm: 250)

    result = find(
      filter: {
        sqm_gte: 220,
        sqm_lte: 300,
      }
    )

    assert_equal(result.map(&:title).sort, [apartment3].map(&:title).sort)
  end

  test 'case two for range filter with sqm_gte and sqm_lte' do
    apartment1 = create(:apartment, sqm: 150)
    apartment2 = create(:apartment, sqm: 120)
    apartment3 = create(:apartment, sqm: 250)

    result = find(
      filter: {
        sqm_gte: 100,
        sqm_lte: 160,
      }
    )

    assert_equal(result.map(&:title).sort, [apartment1, apartment2].map(&:title).sort)
  end

  test 'case three for range filter with sqm_gte and sqm_lte' do
    apartment1 = create(:apartment, sqm: 150)
    apartment2 = create(:apartment, sqm: 120)
    apartment3 = create(:apartment, sqm: 250)

    result = find(
      filter: {
        sqm_gte: 100,
      }
    )

    assert_equal(result.map(&:title).sort, [apartment1, apartment2, apartment3].map(&:title).sort)
  end

  test 'case one for range filter with price_per_sqm_gte and price_per_sqm_lte' do
    apartment1 = create(:apartment, price_per_sqm: 150)
    apartment2 = create(:apartment, price_per_sqm: 120)
    apartment3 = create(:apartment, price_per_sqm: 250)

    result = find(
      filter: {
        price_per_sqm_gte: 220,
        price_per_sqm_lte: 300,
      }
    )

    assert_equal(result.map(&:title).sort, [apartment3].map(&:title).sort)
  end

  test 'case two for range filter with price_per_sqm_gte and price_per_sqm_lte' do
    apartment1 = create(:apartment, price_per_sqm: 150)
    apartment2 = create(:apartment, price_per_sqm: 120)
    apartment3 = create(:apartment, price_per_sqm: 250)

    result = find(
      filter: {
        price_per_sqm_gte: 100,
        price_per_sqm_lte: 160,
      }
    )

    assert_equal(result.map(&:title).sort, [apartment1, apartment2].map(&:title).sort)
  end

  test 'case three for range filter with price_per_sqm_gte and price_per_sqm_lte' do
    apartment1 = create(:apartment, price_per_sqm: 150)
    apartment2 = create(:apartment, price_per_sqm: 120)
    apartment3 = create(:apartment, price_per_sqm: 250)

    result = find(
      filter: {
        price_per_sqm_gte: 100,
      }
    )

    assert_equal(result.map(&:title).sort, [apartment1, apartment2, apartment3].map(&:title).sort)
  end

  test 'get appartments with corret bathroom count' do
    apartment1 = create(:apartment, number_of_bathrooms: 1)
    apartment2 = create(:apartment, number_of_bathrooms: 2)
    apartment3 = create(:apartment, number_of_bathrooms: 3)

    result = find(
      filter: {
        number_of_bathroom: 1,
      }
    )

    assert_equal(result.map(&:title).sort, [apartment1].map(&:title).sort)
  end

  test 'get appartments with corret bedroom count' do
    apartment1 = create(:apartment, number_of_bedrooms: 1)
    apartment2 = create(:apartment, number_of_bedrooms: 2)
    apartment3 = create(:apartment, number_of_bedrooms: 3)

    result = find(
      filter: {
        number_of_bedroom: 1,
      }
    )

    assert_equal(result.map(&:title).sort, [apartment1].map(&:title).sort)
  end
end
