class CreateNotifications < ActiveRecord::Migration[7.2]
  def change
    create_table :notifications do |t|
      t.integer :status, default: 0, null: false
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
