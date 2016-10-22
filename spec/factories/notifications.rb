FactoryGirl.define do
  factory :notification do
    category {Faker::Number.between(0, 2)}
    note {Faker::Lorem.sentence}
    user_id {FactoryGirl.create(:user).id}
  end
end