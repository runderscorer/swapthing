require 'spec_helper'

describe AssignPartners do

  it 'should assign two different people per partnership' do
    partnerships = FactoryGirl.build_list(:partnership, 10)
    AssignPartners.call partnerships

    partnerships.each { |p| expect(p).to be_valid }
  end
end
