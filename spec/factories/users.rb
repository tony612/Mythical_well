FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "username#{n}"}
    sequence(:email) { |n| "test#{n}@test.com"}
    sequence(:name) {|n| "Name#{n}" }
    password 'password'
    password_confirmation 'password'
  end
end
