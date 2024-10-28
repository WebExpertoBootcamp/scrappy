# == Schema Information
#
# Table name: product_histories
#
#  id         :bigint           not null, primary key
#  price      :float
#  product_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ProductHistory < ApplicationRecord
  belongs_to :product
end
