# == Schema Information
#
# Table name: links
#
#  id          :bigint           not null, primary key
#  url         :string
#  category_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  scraper     :string
#
require 'rails_helper'

RSpec.describe Link, type: :model do
  let(:category) { create(:category, name: 'Electronics') }
  let(:link) { create(:link, url: 'http://example.com', category: category, scraper: 'default', isActive: true) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(link).to be_valid
    end

    it 'is not valid without a url' do
      link.url = nil
      expect(link).not_to be_valid
    end

    it 'is not valid without a category' do
      link.category = nil
      expect(link).not_to be_valid
    end
  end
end
