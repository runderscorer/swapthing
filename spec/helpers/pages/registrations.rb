module Pages
  class Registrations
    include Capybara::DSL

    def submit_empty_form
      click_button 'Sign up'
    end
  end
end
