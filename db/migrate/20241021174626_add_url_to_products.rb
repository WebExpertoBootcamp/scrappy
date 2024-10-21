class AddUrlToProducts < ActiveRecord::Migration[7.2]
  def change
    add_column :products, :url, :string
  end
end
