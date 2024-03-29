class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true, index: true
      t.date :event_on
      t.text :comments
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
