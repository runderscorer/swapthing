class Event < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships
  has_many :partnerships
  has_many :invites
  belongs_to :admin, class_name: 'User', foreign_key: 'admin_id'
  validates_presence_of :name, :description, :date, :max_spend

  def self.all_by_user(user)
    joins(:memberships)
    .where(memberships: { user_id: user.id })
    .where('date > ?', Date.today)
    .order('date desc')
  end

  def self.archived_by_user(user)
    joins(:memberships)
    .where(memberships: { user_id: user.id })
    .where('date < ?', Date.today)
    .order('date desc')
  end
end
