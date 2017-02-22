module Pages
  class Events
    include Capybara::DSL

    def open_form
      within('#events') do
        click_on 'a', text: 'Add Event'
      end
    end

    def submit_empty_form
      within('.form_container') do
        click_button 'Add Event'
      end
    end

    def create(name, description, spending_limit)
      within('.form_container') do
        fill_in 'Event Name', with: name
        fill_in 'Description', with: description
        fill_in 'Date', with: Date.today.strftime('%m/%d/%y')
        fill_in 'Spending Limit', with: spending_limit

        click_button 'Add Event'
      end
    end
  end
end
