class Wishlist < ActiveRecord::Base
  belongs_to :user, through: :memberships
  has_many   :gifts
end