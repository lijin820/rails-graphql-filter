module Types
  class QueryType < Types::BaseObject
    field :get_apartments, resolver: Queries::FetchApartments
  end
end
