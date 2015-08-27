class Event < ActiveRecord::Base
  has_many :users, through: :memberships
  has_many :partnerships
  has_many :invites
  has_many :memberships
  belongs_to :admin, class_name: 'User', foreign_key: 'admin_id'

  def self.all_by_user(user)
    joins(:memberships).where(memberships: { user_id: user.id }).order(:created_at)
  end

  def format_date
    self.date = Date.strptime(self.date, '%m/%d/%y')
  end
end
