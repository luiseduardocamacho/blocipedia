FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "MyString"
    password_confirmation "MyString"
    confirmed_at Date.today
  end
end
