require 'spec_helper'

describe 'User visits wishlist page' do
  context 'adding an item' do
    before(:each) do
      user = FactoryGirl.create(:user)

      sign_in(user.email, user.password)
    end

    it 'should open Add Item form' do
      wishlist_page = Pages::Wishlists.new
      wishlist_page.index_no_items
      wishlist_page.open_form

      expect(page).to have_content 'Add Item'
    end

    it 'should create item' do
      wishlist_page = Pages::Wishlists.new
      wishlist_page.index_no_items
      wishlist_page.open_form
      wishlist_page.create('Scary Stories', 'paperback', 15)

      expect(page).to have_content 'Scary Stories'
      expect(page).to have_content 'paperback'
      expect(page).to have_content '$15'
    end
  end
  
  context 'editing an item' do
    before do
      user = FactoryGirl.create(:user)
      wishlist = FactoryGirl.create(:wishlist, user_id: user.id)
      @item = FactoryGirl.create(:item, wishlist_id: wishlist.id)

      sign_in(user.email, user.password)
    end

    it 'should edit an item' do
      wishlist_page = Pages::Wishlists.new
      wishlist_page.index_with_items
      wishlist_page.edit_name(@item.id, 'Twilight Zone')

      expect(page).to have_content 'Twilight Zone'
    end
  end

  context 'deleting an item' do
    before do
      user = FactoryGirl.create(:user)
      wishlist = FactoryGirl.create(:wishlist, user_id: user.id)
      @item = FactoryGirl.create(:item, wishlist_id: wishlist.id)

      sign_in(user.email, user.password)
    end

    it 'should delete an item' do
      wishlist_page = Pages::Wishlists.new
      wishlist_page.index_with_items
      expect(page).to have_content @item.name
      wishlist_page.delete(@item.id)

      expect(page).to_not have_content @item.name
    end
  end
end
