module Pages
  class Registrations
    include Capybara::DSL

    def submit_empty_form
      click_button 'Sign up'
    end

    def submit_with_invalid_email
      fill_in 'First Name', with: 'Ultimate'
      fill_in 'Last Name', with: 'Warrior'
      fill_in 'Email', with: 'email'
      fill_in 'Password', with: 'password'
      fill_in 'Confirm Password', with: 'password'
      click_button 'Sign up'
    end

    def submit_with_non_matching_passwords
      fill_in 'First Name', with: 'Ultimate'
      fill_in 'Last Name', with: 'Warrior'
      fill_in 'Email', with: 'email'
      fill_in 'Password', with: 'password1'
      fill_in 'Confirm Password', with: 'password2'
      click_button 'Sign up'
    end

    def submit_with_invalid_password
      fill_in 'First Name', with: 'Ultimate'
      fill_in 'Last Name', with: 'Warrior'
      fill_in 'Email', with: 'email'
      fill_in 'Password', with: 'pw'
      fill_in 'Confirm Password', with: 'pw'
      click_button 'Sign up'
    end
  end
end
