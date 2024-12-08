FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "freddy#{n}@elmst.com" }
    fname { 'Freddy' }
    lname { 'Krueger' }
    password { 'passwordy' }

    trait :with_membership do
      transient do
        event_id { create(:event).id }
      end

      after(:create) do |user, evaluator|
        create(:membership, user: user, event_id: evaluator.event_id)
      end
    end
  end
end
