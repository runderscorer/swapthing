class Item < ActiveRecord::Base
  belongs_to :wishlist

  def short_url
    self.url.split('.')[1]
  end
end