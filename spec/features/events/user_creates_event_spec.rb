require 'spec_helper'

describe 'User creating event' do
  before(:all) do
    user = FactoryGirl.create(:user)

    sign_in(user.email, user.password)
  end

  it 'should display error messages' do

  end
end
