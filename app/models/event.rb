class Event < ActiveRecord::Base
  has_many :users, through: :roles
  has_many :roles

  def self.all_by_user(user)
    joins(:roles).where(roles: { user_id: user.id }).order(:created_at)
  end
end
