class AddImportIdToRentals < ActiveRecord::Migration
  def change
    add_column :rentals, :import_id, :string
  end
end
