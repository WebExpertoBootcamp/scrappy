class CreateProductHistories < ActiveRecord::Migration[7.2]
  def change
    create_table :product_histories do |t|
      t.float :price
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
