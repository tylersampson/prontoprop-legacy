class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :addressable, polymorphic: true, index: true
      t.string :unit
      t.string :complex
      t.string :street_no
      t.string :street_name
      t.string :crossing_street
      t.string :suburb
      t.string :city
      t.string :country
      t.string :code

      t.timestamps null: false
    end
  end
end
