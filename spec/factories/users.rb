# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name 'Test User'
    sequence(:email) { |n| "example#{n}@example.com" }
    password 'changeme'
    password_confirmation 'changeme'
    # required if the Devise Confirmable module is used
    confirmed_at Time.now
  end

  factory :admin, parent: :user do
    admin true
  end
end
