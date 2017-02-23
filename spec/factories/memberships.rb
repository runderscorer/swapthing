FactoryGirl.define do
  factory :membership do
    sequence(:event_id) { |n| n }
    sequence(:user_id) { |n| n }
  end
end
