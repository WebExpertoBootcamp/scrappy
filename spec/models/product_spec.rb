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
require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:category) { create(:category, name: 'Electronics') }
  let(:product) { create(:product, name: 'Laptop', description: 'A powerful laptop', price: 1000.0, category: category, url: 'http://example.com', img_url: 'http://example.com/image.jpg', sku: '12345') }
  describe 'associations' do
    it { should belong_to(:category) }
    it { should have_many(:product_histories) }
  end

  describe 'callbacks' do
    it 'creates a product history after update' do
      product.update(price: 1200.0)
      expect(ProductHistory.last.price).to eq(1200.0)
    end
  end
end
