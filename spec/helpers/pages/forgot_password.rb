module Pages
  class ForgotPassword
    include Capybara::DSL

    def submit_without_email
      click_button 'Reset Password'
    end
  end
end
