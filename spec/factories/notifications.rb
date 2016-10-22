FactoryGirl.define do
  factory :notification do
    type {Faker::Number.between(0, 2)}
    note {Faker::Lorem.sentence}
  end
end