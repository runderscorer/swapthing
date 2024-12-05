class Exclusion < ActiveRecord::Base
  belongs_to :user
  belongs_to :excluded_user, class_name: 'User'

  def build_partner_exclusion!
    Exclusion.new(user: excluded_user, excluded_user: user)
  end
end
