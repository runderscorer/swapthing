FactoryGirl.define do
  factory :partnership do
    sequence(:giver_id) { |n| n}
    event_id '1000'
  end
end