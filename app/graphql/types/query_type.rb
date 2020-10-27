module Types
  class QueryType < BaseObject
    add_field GraphQL::Types::Relay::NodeField
    add_field GraphQL::Types::Relay::NodesField

    field :all_apartments, resolver: Resolvers::ApartmentSearch
    field :_all_apartments_meta, QueryMetaType, null: false

    def _all_apartments_meta
      Apartment.count
    end
  end
end
