class AddProductSkuToProduct < ActiveRecord::Migration[7.2]
  def change
    add_column :products, :sku, :string
  end
end
