class AddImgUrlToProducts < ActiveRecord::Migration[7.2]
  def change
    add_column :products, :img_url, :string
  end
end
