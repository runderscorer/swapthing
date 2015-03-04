class Partnership < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  validate :cannot_get_self

  private

  def cannot_get_self
    errors.add(:getter_id, 'Giver and getter must be different') if giver_id == getter_id
  end
end