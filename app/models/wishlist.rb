class Wishlist < ActiveRecord::Base
  belongs_to :partnership
  has_many   :items
end