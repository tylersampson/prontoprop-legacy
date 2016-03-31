class AddCodeToRentals < ActiveRecord::Migration
  def change
    add_column :rentals, :code, :string
  end
end
