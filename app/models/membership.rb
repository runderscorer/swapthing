class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_one    :wishlist
  delegate   :email, to: :user, prefix: true
end