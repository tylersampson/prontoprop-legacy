class CreateRentals < ActiveRecord::Migration
  def change
    create_table :rentals do |t|
      t.references :lease, index: true, foreign_key: true
      t.date :date_received
      t.decimal :amount_received, precision: 12, scale: 2
      t.decimal :commission, precision: 12, scale: 2
      t.decimal :vat, precision: 12, scale: 2

      t.timestamps null: false
    end
  end
end
