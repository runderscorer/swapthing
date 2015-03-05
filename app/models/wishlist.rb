class Wishlist < ActiveRecord::Base
  belongs_to :membership
  has_many   :items
end