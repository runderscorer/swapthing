class Partnership < ActiveRecord::Base
  belongs_to :event
  belongs_to :giver, class_name: 'User', foreign_key: 'giver_id'
  belongs_to :getter, class_name: 'User', foreign_key: 'getter_id'
  has_one    :wishlist

  validate :cannot_get_self

  private

  def cannot_get_self
    errors.add(:getter_id, 'Giver and getter must be different') if giver_id == getter_id
  end
end