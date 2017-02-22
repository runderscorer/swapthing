require 'spec_helper'

describe Event, type: :model do
  context 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :date }
    it { should validate_presence_of :max_spend }
  end

  context 'associations' do
    it { should have_many :users }
    it { should have_many :invites }
    it { should have_many :partnerships }
    it { should have_many :memberships }
    it { should belong_to :admin }
  end
end
