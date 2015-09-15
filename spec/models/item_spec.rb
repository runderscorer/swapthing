require 'spec_helper'

describe Item do
  context 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :price }
    it { should validate_presence_of :wishlist_id }
  end

  context 'associations' do
    it { should belong_to :wishlist }
  end
end