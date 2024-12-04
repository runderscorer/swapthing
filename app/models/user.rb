class User < ActiveRecord::Base
  include InvitesHelper
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :events, class_name: 'Event', foreign_key: 'admin_id'
  has_many :memberships
  has_many :partnerships, class_name: 'Partnership', foreign_key: 'giver_id'
  has_one  :wishlist
  has_many :sent_invites, class_name: 'Invite', foreign_key: 'sender_id'
  has_one :exclusion

  before_save :downcase_email

  validates_presence_of :fname, :lname, :email

  def full_name
    "#{fname} #{lname}"
  end

  def downcase_email
    self.email.downcase!
  end

  def has_pending_invites?
    user_invite_helper = InvitesHelper::UserInvite.new(self)
    user_invite_helper.pending.any?
  end
end
