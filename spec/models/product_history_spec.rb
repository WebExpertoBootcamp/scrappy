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
require 'rails_helper'

RSpec.describe ProductHistory, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
