FactoryGirl.define do
  factory :user do
    name "Test User"
    sequence(:email) { |n| "example#{n}@example.com" }
    sequence(:username) { |n| "User #{n}" }
    password "changeme"
    password_confirmation "changeme"
    # required if the Devise Confirmable module is used
    confirmed_at Time.now
  end

  factory :admin, parent: :user do
    admin true
  end
end
