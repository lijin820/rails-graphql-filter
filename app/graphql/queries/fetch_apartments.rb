# frozen_string_literal: true
module Queries
  # fetch apartments by sort key
  class FetchApartments < Queries::BaseQuery
    type [Types::ApartmentType], null: false

    def resolve
      Apartment.all.order(created_at: :desc)
    end
  end
end
