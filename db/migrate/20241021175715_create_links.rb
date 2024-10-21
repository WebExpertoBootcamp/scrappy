class CreateLinks < ActiveRecord::Migration[7.2]
  def change
    create_table :links do |t|
      t.string :url
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
