require 'rails_helper'

RSpec.describe Apartment, type: :model do
  context 'validation test' do
    it 'ensures name presence' do
      apartment = Apartment.new(name: 'TestApartment').save
      expect(apartment).to eq(true)
    end
  end
end
