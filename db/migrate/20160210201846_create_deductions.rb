class CreateDeductions < ActiveRecord::Migration
  def change
    create_table :deductions do |t|
      t.references :commission, index: true, foreign_key: true      
      t.references :deductable, index: true, foreign_key: true
      t.decimal :amount, precision: 12, scale: 2

      t.timestamps null: false
    end
  end
end
