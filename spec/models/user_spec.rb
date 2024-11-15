# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_type        :string
#  invited_by_id          :bigint
#  invitations_count      :integer          default(0)
#  role                   :string
#
require 'rails_helper'

RSpec.describe User, type: :model do
    describe "validations" do
    it "validate presence of required fields" do
      should validate_presence_of(:email)
      should validate_presence_of(:password)
    end
  end

  describe "associations" do
    it "has and belongs to many categories" do
      should have_and_belong_to_many(:categories)
    end
  end

  describe "roles" do
    it "sets default role to User" do
      user = User.new
      expect(user.role).to eq('User')
    end

    it "returns true if role is Admin" do
      user = User.new(role: 'Admin')
      expect(user.admin?).to be true
    end

    it "returns true if role is User" do
      user = User.new(role: 'User')
      expect(user.user?).to be true
    end
  end
end
