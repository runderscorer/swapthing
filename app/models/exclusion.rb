class Exclusion < ActiveRecord::Base
  belongs_to :user
  belongs_to :excluded_user, class_name: 'User'
end
