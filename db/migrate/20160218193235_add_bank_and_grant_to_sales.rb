class AddBankAndGrantToSales < ActiveRecord::Migration
  def change
    add_reference :sales, :bank, index: true, foreign_key: true
    add_column :sales, :grant_amount, :decimal, precision: 12, scale: 2
  end
end
