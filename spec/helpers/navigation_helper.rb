module NavigationHelper
  def sign_in(email, password)
    visit root_path
    within('.sign_in_container') do
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_button 'Sign in'
    end
  end
end
