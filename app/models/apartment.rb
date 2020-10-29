# frozen_string_literal: true

class Apartment < ApplicationRecord
  validates :title, presence: true
  validates :price, presence: true
  validates :sqm, presence: true
  validates :number_of_bedrooms, presence: true
  validates :number_of_bathrooms, presence: true
end
