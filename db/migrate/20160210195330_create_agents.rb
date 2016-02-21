class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.string :code
      t.string :first_name
      t.string :last_name
      t.string :id_number
      t.string :email
      t.string :mobile
      t.decimal :tax, precision: 4, scale: 2

      t.timestamps null: false
    end
  end
end
