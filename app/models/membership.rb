class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  delegate   :email, to: :user, prefix: true

end