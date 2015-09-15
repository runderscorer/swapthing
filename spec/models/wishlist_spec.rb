require 'spec_helper'

describe Wishlist do
  context 'validations' do
    it { should validate_presence_of :user_id }
  end

  context 'associations' do
    it { should have_many :items }
    it { should belong_to :user }
  end
end