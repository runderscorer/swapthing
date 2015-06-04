class Invite < ActiveRecord::Base
  belongs_to :event
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  before_create :generate_token

  def self.pending
    where accepted_at: nil
  end

  private

  def generate_token
    self.token = SecureRandom.hex(16)
  end
end