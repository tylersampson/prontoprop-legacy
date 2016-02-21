class AddFeesToRentals < ActiveRecord::Migration
  def change
    add_column :rentals, :fees, :decimal, precision: 12, scale: 2
  end
end
