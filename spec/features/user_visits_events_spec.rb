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

  context 'viewing events' do
    before(:each) do
      user = FactoryGirl.create(:user)
      @future_event = FactoryGirl.create(:event, date: Date.today + 30.days)
      @past_event = FactoryGirl.create(:event, date: Date.today - 30.days)
      FactoryGirl.create(:membership, event_id: @future_event.id, user_id: user.id)
      FactoryGirl.create(:membership, event_id: @past_event.id, user_id: user.id)

      sign_in(user.email, user.password)
    end

    it 'should list events by descending date' do
      first_listed_date = all('.event_date').first.text
      last_listed_date = all('.event_date').last.text

      expect(first_listed_date).to eq @future_event.date.strftime('%b %d %Y')
      expect(last_listed_date).to eq @past_event.date.strftime('%b %d %Y')
    end
  end
end
