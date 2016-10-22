class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :category,  null: false
      t.text    :note,      null: false
      t.boolean :confirmed, default: false
      
      t.references :user, null: false

      t.timestamps
    end
  end
end
