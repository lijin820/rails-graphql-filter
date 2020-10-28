require 'test_helper'

class Resolvers::ApartmentSearchTest < ActiveSupport::TestCase
  def find(args)
    Resolvers::ApartmentSearch.call(nil, args, nil)
  end

  test 'skip option' do
    apartment = create :apartment, title: 'old'
    create :apartment, title: 'new'

    assert_equal find(skip: 1), [apartment]
  end

  test 'first option' do
    create :apartment, title: 'old'
    apartment = create :apartment, title: 'new'

    assert_equal find(first: 1), [apartment]
  end

  test 'filter option' do
    apartment1 = create :apartment, title: 'test1'
    apartment2 = create :apartment, title: 'test2'
    apartment3 = create :apartment, title: 'test3'
    create :apartment, title: 'test4'

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

    assert_equal result.map(&:title).sort, [apartment1, apartment2, apartment3].map(&:title).sort
  end

  test 'order by createdAt_ASC' do
    new = create :apartment, created_at: 1.week.ago
    old = create :apartment, created_at: 1.month.ago

    assert_equal find(orderBy: 'createdAt_ASC'), [old, new]
  end

  test 'order by createdAt_DESC' do
    new = create :apartment, created_at: 1.week.ago
    old = create :apartment, created_at: 1.month.ago

    assert_equal find(orderBy: 'createdAt_DESC'), [new, old]
  end
end
