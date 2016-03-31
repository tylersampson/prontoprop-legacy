class CreateOriginators < ActiveRecord::Migration
  def change
    create_table :originators do |t|
      t.string :code
      t.string :name
      t.string :email
      t.string :telephone
      t.boolean :preferred

      t.timestamps null: false
    end
  end
end
