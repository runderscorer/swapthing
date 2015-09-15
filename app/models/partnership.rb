class Partnership < ActiveRecord::Base
  belongs_to :event
  belongs_to :giver, class_name: 'User', foreign_key: 'giver_id'
  belongs_to :getter, class_name: 'User', foreign_key: 'getter_id'

  validates :event_id, presence: true
  validates :giver_id, presence: true
  validates :getter_id, presence: true
  validate :cannot_get_self

  private

  def cannot_get_self
    errors.add(:getter_id, 'Giver and getter must be different') if giver_id == getter_id
  end
end