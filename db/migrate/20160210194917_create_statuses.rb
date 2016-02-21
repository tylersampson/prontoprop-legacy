class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :name
      t.integer :access
      t.string :category

      t.timestamps null: false
    end
  end
end
