class Link < ApplicationRecord
  belongs_to :category
  validates :url, presence: true
end
