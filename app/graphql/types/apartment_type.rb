module Types
  class ApartmentType < Types::BaseNode
    field :id, ID, null: false
    field :title, String, null: true
    field :price, Integer, null: true
    field :sqm, Integer, null: true
    field :price_per_sqm, Integer, null: true
    field :number_of_bedrooms, Integer, null: true
    field :number_of_bathrooms, Integer, null: true
    field :picture, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
