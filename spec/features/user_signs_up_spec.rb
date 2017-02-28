require 'spec_helper'

describe 'User signs up' do
  before do
    visit root_path
    click_link 'Sign up'
  end
  
  it 'should display error messages' do
    registration_page = Pages::Registrations.new
    registration_page.submit_empty_form

    expect(page).to have_content 'Required field', count: 4
  end
  
  it 'should validate email address' do
    registration_page = Pages::Registrations.new
    registration_page.submit_with_invalid_email

    expect(page).to have_content 'Invalid email address'
  end

  it 'should check that passwords match' do
    registration_page = Pages::Registrations.new
    registration_page.submit_with_non_matching_passwords

    expect(page).to have_content 'Passwords do not match'
  end

  it 'should validate password' do
    registration_page = Pages::Registrations.new
    registration_page.submit_with_invalid_password

    expect(page).to have_content 'Password must be at least 8 characters'
  end
end
