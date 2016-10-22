FactoryGirl.define do
  factory :comment do
    comment {Faker::Lorem.sentence}
    notification_id {FactoryGirl.create(:notification).id}
    user_id {FactoryGirl.create(:user).id}
  end
end