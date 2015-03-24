class Wishlist < ActiveRecord::Base
  belongs_to :user
  belongs_to :membership
  has_many   :items

  accepts_nested_attributes_for :items, allow_destroy: true
end