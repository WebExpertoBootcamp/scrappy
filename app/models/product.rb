# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  price       :float
#  category_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  url         :string
#  img_url     :string
#  sku         :string
#
class Product < ApplicationRecord
  belongs_to :category
  has_many :product_histories

  after_update :create_product_history

  private

  def create_product_history
    ProductHistory.create(
      product_id: self.id,
      price: self.price,
      created_at: self.created_at,
      updated_at: self.updated_at
    )
  end
end


