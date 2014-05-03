# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :blip do
    sequence(:name) { |n| "Blip #{n}" }
    quadrant 'tools'
    ring 'adopt'
  end
end
