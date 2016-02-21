class CreateCommissions < ActiveRecord::Migration
  def change
    create_table :commissions do |t|
      t.references :commissionable, polymorphic: true, index: true
      t.references :agent, index: true, foreign_key: true
      t.decimal :commission_percent, precision: 5, scale: 2
      t.decimal :gross_amount, precision: 12, scale: 2
      t.decimal :tax_percent, precision: 5, scale: 2
      t.decimal :total_tax, precision: 12, scale: 2
      t.decimal :nett_amount, precision: 12, scale: 2
      
      t.timestamps null: false
    end
  end
end
