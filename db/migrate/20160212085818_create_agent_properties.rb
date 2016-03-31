class CreateAgentProperties < ActiveRecord::Migration
  def change
    create_table :agent_properties do |t|
      t.references :agent, index: true, foreign_key: true
      t.references :property, index: true, foreign_key: true
      t.decimal :commission_percent, precision: 5, scale: 2

      t.timestamps null: false
    end
  end
end
