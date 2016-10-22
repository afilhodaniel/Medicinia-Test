class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :comment, null: false

      t.references :notification, null: false
      t.references :user,         null: false

      t.timestamps
    end
  end
end
