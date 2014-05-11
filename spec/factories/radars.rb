# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :radar do
    sequence(:name) { |n| "Radar #{n}" }
    association :owner, factory: :user
  end
end
