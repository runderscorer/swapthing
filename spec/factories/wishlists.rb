FactoryGirl.define do
  factory :wishlist do
    sequence(:user_id) { |n| n }
  end
end
