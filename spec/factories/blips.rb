FactoryGirl.define do
  factory :blip do
    sequence(:name) { |n| "Blip #{n}" }
    quadrant 'tools'
    ring 'adopt'
    radar
  end
end
