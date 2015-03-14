class Event < ActiveRecord::Base
  has_many :users, through: :memberships
  has_many :partnerships
  has_many :invites
  has_many :memberships

  def self.all_by_user(user)
    joins(:memberships).where(memberships: { user_id: user.id }).order(:created_at)
  end
end
