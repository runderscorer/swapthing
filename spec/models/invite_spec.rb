require 'spec_helper'

describe Invite, type: :model do
  context 'validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :token }
  end

  context 'associations' do
    it { should belong_to :event }
    it { should belong_to :sender }
    it { should belong_to :recipient }
  end
end
