class Invite < ActiveRecord::Base
  belongs_to :event
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :event, class_name: 'Event', foreign_key: 'event_id'
  belongs_to :recipient, class_name: 'User'
  validates_presence_of :email
  validates_presence_of :token

  before_create :generate_token
  before_save :downcase_email

  def self.pending
    where accepted_at: nil
  end

  private

  def generate_token
    self.token = SecureRandom.hex(16)
  end

  def downcase_email
    self.email.downcase!
  end
end