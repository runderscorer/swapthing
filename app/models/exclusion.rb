class Exclusion < ActiveRecord::Base
  belongs_to :user
  belongs_to :excluded_user, class_name: 'User'

  validates_presence_of :user, :excluded_user
  validate :user_and_excluded_user_are_not_the_same

  def build_partner_exclusion!
    Exclusion.new(user: excluded_user, excluded_user: user)
  end

  def user_and_excluded_user_are_not_the_same
    if user == excluded_user
      errors.add(:excluded_user_id, "You can't excluded yourself, silly!")
    end
  end
end
