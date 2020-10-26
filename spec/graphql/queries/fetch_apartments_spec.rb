require 'rails_helper'

module Queries
  RSpec.describe FetchApartments, type: :request do
    describe '.resolve' do
      it 'return apartments' do
        create(:apartment, name: 'Apartment1')
        post '/graphql', params: { query: query() }
        json = JSON.parse(response.body)
        data = json['data']['getApartments']
        expect(data).to match_array [
          hash_including(
            'id'     => be_present,
            'name'   => 'Apartment1',
          )
        ]
      end
    end

    def query()
      <<~GQL
        query {
          getApartments {
            id
            name
          }
        }
      GQL
    end
  end
end
