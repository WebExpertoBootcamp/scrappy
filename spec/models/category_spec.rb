# == Schema Information
#
# Table name: categories
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { create(:category, name: 'Electronics', description: 'Devices and gadgets') }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(category).to be_valid
    end

    it 'is not valid without a name' do
      category.name = nil
      expect(category).not_to be_valid
    end

    it 'is not valid without a description' do
      category.description = nil
      expect(category).not_to be_valid
    end

  end
end
