# frozen_string_literal: true
require 'search_object'
require 'search_object/plugin/graphql'
require 'graphql/query_resolver'

# fetch apartments by sort key
class Resolvers::ApartmentSearch
  include SearchObject.module(:graphql)

  scope { Apartment.all }

  type [Types::ApartmentType]

  class ApartmentFilter < ::Types::BaseInputObject
    argument :title_contains, String, required: false
    argument :OR, [self], required: false
    argument :price_gte, Float, required: false
    argument :price_lte, Float, required: false
    argument :sqm_gte, Float, required: false
    argument :sqm_lte, Float, required: false
  end

  class ApartmentOrderBy < ::Types::BaseEnum
    value 'createdAt_ASC'
    value 'createdAt_DESC'
  end

  option :filter, type: ApartmentFilter, with: :apply_filter
  option :first, type: types.Int, with: :apply_first
  option :skip, type: types.Int, with: :apply_skip
  option :orderBy, type: ApartmentOrderBy, default: 'createdAt_DESC'

  def apply_filter(scope, value)
    branches = normalize_filters(value).reduce { |a, b| a.or(b) }
    scope.merge branches
  end

  def normalize_filters(value, branches = [])
    scope = Apartment.all
    scope = scope.where('title LIKE ?', "%#{value[:title_contains]}%") if value[:title_contains]
    scope = scope.where('price <= ?', value[:price_lte]) if value[:price_lte]
    scope = scope.where('price >= ?', value[:price_gte]) if value[:price_gte]
    scope = scope.where('sqm <= ?', value[:sqm_lte]) if value[:sqm_lte]
    scope = scope.where('sqm >= ?', value[:sqm_gte]) if value[:sqm_gte]

    branches << scope

    value[:OR].reduce(branches) { |s, v| normalize_filters(v, s) } if value[:OR].present?

    branches
  end

  def apply_first(scope, value)
    scope.limit(value)
  end

  def apply_skip(scope, value)
    scope.offset(value)
  end

  def apply_order_by_with_created_at_asc(scope)
    scope.order('created_at ASC')
  end

  def apply_order_by_with_created_at_desc(scope)
    scope.order('created_at DESC')
  end

  def fetch_results
    # NOTE: Don't run QueryResolver during tests
    return super unless context.present?

    GraphQL::QueryResolver.run(Apartment, context, Types::ApartmentType) do
      super
    end
  end
end
