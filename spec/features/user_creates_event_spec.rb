require 'spec_helper'

describe 'User creating event' do
  context 'adding event' do
    before(:each) do
      user = FactoryGirl.create(:user)

      sign_in(user.email, user.password)
    end

    it 'should display Add Event form' do
      events_page = Pages::Events.new
      events_page.open_form

      expect(page).to have_content 'Add Event'
    end

    it 'should display errors' do
      events_page = Pages::Events.new
      events_page.open_form
      events_page.submit_empty_form

      expect(page).to have_content 'Required field'
    end

    it 'should create event' do
      events_page = Pages::Events.new
      events_page.open_form
      events_page.create('Wrestlemania', 'Wrasslin time!', 500)

      expect(page).to have_content 'Wrestlemania'
    end
  end

  context 'editing event' do
    before(:each) do
      user = FactoryGirl.create(:user)
      @event = FactoryGirl.create(:event, admin_id: user.id)
      FactoryGirl.create(:membership, event_id: @event.id, user_id: user.id)

      sign_in(user.email, user.password)
    end

    it 'should update the event name' do
      events_page = Pages::Events.new
      events_page.edit_name(@event.id, 'Halloween Bash')

      expect(page).to have_content 'Halloween Bash'
    end
  end
end
