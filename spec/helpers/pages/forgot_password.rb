module Pages
  class ForgotPassword
    include Capybara::DSL

    def submit(email)
      fill_in 'Email', with: email
      click_button 'Reset Password'
    end

    def submit_without_email
      click_button 'Reset Password'
    end
  end
end
