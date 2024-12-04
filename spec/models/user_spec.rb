require 'spec_helper'

describe User, type: :model do
  context 'validations' do
    it { should validate_presence_of :fname }
    it { should validate_presence_of :fname }
    it { should validate_presence_of :email }
  end

  context 'associations' do
    it { should have_many :events }
    it { should have_many :memberships }
    it { should have_many :partnerships }
    it { should have_many :sent_invites }
    it { should have_many :received_invites }
    it { should have_one :wishlist }
    it { should have_one :exclusion }
  end
end
