class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  delegate   :email, to: :user, prefix: true
  validates_uniqueness_of :user_id, scope: :event_id, message: 'already exists'
end