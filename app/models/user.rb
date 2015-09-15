class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :events, class_name: 'Event', foreign_key: 'admin_id'
  has_many :memberships
  has_many :partnerships, class_name: 'Partnership', foreign_key: 'giver_id'
  has_one  :wishlist
  has_many :invitations, class_name: 'Invite', foreign_key: 'sender_id'
  has_many :sent_invites, class_name: 'Invite', foreign_key: 'recipient_id'

  validates_presence_of :fname, :lname, :email


  def full_name
    "#{fname} #{lname}"
  end
end
