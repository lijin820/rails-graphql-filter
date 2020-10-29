class UpdateApartmentField < ActiveRecord::Migration[6.0]
  def change
    add_column :apartments, :price_per_sqm, :float
  end
end
