require 'spec_helper'

describe Partnership do
  context 'validations' do
    it { should validate_presence_of :event_id }
    it { should validate_presence_of :giver_id }
    it { should validate_presence_of :getter_id }

    it 'should not allow a person to be both the giver and the getter' do
      partnership = Partnership.create(giver_id: 1000, getter_id: 1000, event_id: 1)
      
      expect(partnership).to_not be_valid
    end
  end

  context 'associations' do
    it { should belong_to :event }
  end
end