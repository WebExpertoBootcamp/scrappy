# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, :all # Admin puede hacer todo
    elsif user.user?
    end
  end
end
