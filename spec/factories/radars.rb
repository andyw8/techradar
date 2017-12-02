FactoryBot.define do
  factory :radar do
    sequence(:name) { |n| "Radar #{n}" }
    association :owner, factory: :user
  end
end
