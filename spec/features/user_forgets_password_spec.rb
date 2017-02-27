require 'spec_helper'

describe 'User resets password' do
  before do
    visit root_path
    click_link 'Forgot password'
  end

  it 'should display error message' do
    forgot_password_page = Pages::ForgotPassword.new
    forgot_password_page.submit_without_email

    expect(page).to have_content 'Bummer. There was a problem with your email.'
  end
end
