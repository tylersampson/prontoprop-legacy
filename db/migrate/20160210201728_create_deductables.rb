class CreateDeductables < ActiveRecord::Migration
  def change
    create_table :deductables do |t|
      t.string :code
      t.string :name
      t.decimal :unit_price, precision: 12, scale: 2

      t.timestamps null: false
    end
  end
end
