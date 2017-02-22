require 'spec_helper'

describe 'User visits wishlist page' do
  before(:each) do
    user = FactoryGirl.create(:user)

    sign_in(user.email, user.password)
  end

  it 'should open Add Item form' do
    wishlist_page = Pages::Wishlists.new
    wishlist_page.index
    wishlist_page.open_form

    expect(page).to have_content 'Add Item'
  end

  it 'should create item' do
    wishlist_page = Pages::Wishlists.new
    wishlist_page.index
    wishlist_page.open_form
    wishlist_page.create('Scary Stories', 'paperback', 15)

    expect(page).to have_content 'Scary Stories'
    expect(page).to have_content 'paperback'
    expect(page).to have_content '$15'
  end
end
