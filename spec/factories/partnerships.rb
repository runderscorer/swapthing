FactoryBot.define do
  factory :partnership do
    sequence(:giver_id) { |n| n}
    event_id { create(:event).id }
  end
end