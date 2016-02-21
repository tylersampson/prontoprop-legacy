class AddPaidOnToCommissions < ActiveRecord::Migration
  def change
    add_column :commissions, :paid_on, :date
  end
end
