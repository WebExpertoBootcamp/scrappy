class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  after_initialize :set_default_role, if: :new_record?

  ROLES = %w[Admin User].freeze



  def admin?
    role == 'Admin'
  end

  def user?
    role == 'User'
  end

  private

  def set_default_role
    self.role ||= 'User'
  end
end
