require 'spec_helper'

describe 'User resets password' do
  it 'should display error message' do
    visit root_path
    click_link 'Forgot password'
    forgot_password_page = Pages::ForgotPassword.new
    forgot_password_page.submit_without_email

    expect(page).to have_content 'Bummer. There was a problem with your email address'
  end

  it 'should display confirmation message' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Forgot password'
    forgot_password_page = Pages::ForgotPassword.new
    forgot_password_page.submit user.email

    expect(page).to have_content "Hang tight - A password reset has been sent to #{user.email}"
  end
end
