class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.references :contactable, polymorphic: true, index: true
      t.string :name
      t.string :email
      t.string :mobile
      t.string :telephone

      t.timestamps null: false
    end
  end
end
