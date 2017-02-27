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

end
