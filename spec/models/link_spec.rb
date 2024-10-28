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
  pending "add some examples to (or delete) #{__FILE__}"
end
