class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :code
      t.references :property, index: true, foreign_key: true
      t.references :buyer, index: true
      t.decimal :purchase_price, precision: 12, scale: 2
      t.decimal :deposit_amount, precision: 12, scale: 2
      t.date :deposit_due_on
      t.references :attorney, index: true, foreign_key: true
      t.references :bond_attorney, index: true
      t.date :bond_due_on
      t.references :originator, index: true, foreign_key: true
      t.string :external_id      
      t.decimal :commission, precision: 12, scale: 2
      t.decimal :vat, precision: 12, scale: 2
      t.references :status, index: true, foreign_key: true
      t.date :registered_on, index: true
      t.date :contract_start_on, index: true

      t.timestamps null: false
    end
    
    add_foreign_key :sales, :contacts, column: :buyer_id
    add_foreign_key :sales, :attorneys, column: :bond_attorney_id
  end
end
