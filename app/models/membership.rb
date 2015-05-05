class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_one    :wishlist
  has_one    :partnership
  delegate   :email, to: :user, prefix: true

  def self.partner
    User.find self.partnership.getter_id
  end
end