FactoryGirl.define do
  factory :topic do
    sequence(:name) { |n| "Topic #{n}" }
    sequence(:slug) { |n| "topic-#{n}" }
    association :creator, factory: :user
  end
end
