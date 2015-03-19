class Wishlist < ActiveRecord::Base
  belongs_to :user
  belongs_to :membership
  has_many   :items
end