class CreateLeases < ActiveRecord::Migration
  def change
    create_table :leases do |t|
      t.string :code
      t.references :property, index: true, foreign_key: true
      t.references :lessor, index: true
      t.boolean :managed
      t.date :start_on
      t.date :end_on
      t.date :actual_end_on
      t.decimal :rent_amount, precision: 12, scale: 2
      t.decimal :deposit_amount, precision: 12, scale: 2
      t.string :deposit_held_by
      t.decimal :lease_fee, precision: 12, scale: 2
      t.decimal :inspection_fee, precision: 12, scale: 2
      t.decimal :credit_check_fee, precision: 12, scale: 2
      t.date :credit_check_fee_paid_on
      t.date :deposit_released_on
      t.string :deposit_released_to
      t.references :status, index: true, foreign_key: true

      t.timestamps null: false
    end
    
    add_foreign_key :leases, :contacts, column: :lessor_id
  end
end
