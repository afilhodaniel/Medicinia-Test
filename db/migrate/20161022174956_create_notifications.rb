class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :category, null: false
      t.text    :note,     null: false
      
      t.timestamps
    end
  end
end
