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
class Category < ApplicationRecord
    #has_and_belongs_to_many :users
    has_many :links, dependent: :destroy
    validates :name, presence: true, uniqueness: true
    validates :description, presence: true

    #atributo anidado para crear url dentro de category
    accepts_nested_attributes_for :links, allow_destroy: true
end
