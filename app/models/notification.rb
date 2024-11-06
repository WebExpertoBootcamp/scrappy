class Notification < ApplicationRecord
  belongs_to :product
  belongs_to :category

  enum :status, [:pending, :sent], prefix: true
end
