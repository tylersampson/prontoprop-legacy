class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :code
      t.string :name
      t.references :owner, index: true
      t.string :listing_type
      t.string :external_id

      t.timestamps null: false
    end
    
    add_foreign_key :properties, :contacts, column: :owner_id
  end
end
