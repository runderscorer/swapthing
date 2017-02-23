FactoryGirl.define do
  factory :event do
    sequence(:admin_id) { |n| n }
    sequence(:name) { |n| "Summerslam #{n}" }
    description 'Dropkicks and clotheslines'
    max_spend 100
    date Date.today
  end
end
