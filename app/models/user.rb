class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    ROLES = %w[Admin User].freeze

  after_initialize :set_default_role, if: :new_record?

  private

  def set_default_role
    self.role ||= 'User'
  end
end
