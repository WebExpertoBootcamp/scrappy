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
  let(:category) { create(:category, name: 'Electronics') }
  let(:product) { create(:product, name: 'Laptop', description: 'A powerful laptop', price: 1000.0, category: category, url: 'http://example.com', img_url: 'http://example.com/image.jpg', sku: '12345') }

  describe 'callbacks' do
    it 'creates a product history after update' do
      expect {
        product.update(price: 1200.0)
      }.to change { ProductHistory.count }.by(1)
    end

    it 'creates a notification when price decreases' do
      product.update(price: 1200.0)
      product.update(price: 800.0)
      notification = Notification.last
      expect(notification).not_to be_nil
      expect(notification.message).to include("ha bajado de precio")
    end

    it 'creates a notification when price increases' do
      product.update(price: 1200.0)
      product.update(price: 1400.0)
      notification = Notification.last
      expect(notification).not_to be_nil
      expect(notification.message).to include("ha subido de precio")
    end
  end
end
