class Role < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_one :partner, class_name: 'User', foreign_key: 'partner_id'
end
