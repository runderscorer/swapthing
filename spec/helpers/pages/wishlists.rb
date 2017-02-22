module Pages
  class Wishlists
    include Capybara::DSL

    def index
      within('ul.navbar-list') do
        click_link 'Create Wishlist'
      end
    end

    def open_form
      within('#wishlist') do
        click_on 'a', text: 'Add Item'
      end
    end

    def create(name, notes, price)
      within('.form_container') do
        fill_in 'Item Name', with: name
        fill_in 'Notes', with: notes
        fill_in 'Price', with: price

        click_button 'Add Item'
      end
    end
  end
end
