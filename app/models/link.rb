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
class Link < ApplicationRecord
  belongs_to :category
  validates :url, presence: true
end
