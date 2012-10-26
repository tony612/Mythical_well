require 'factory_girl'
FactoryGirl.define do
  factory :user do
    username 'username'
    email 'test@test.com'
    name 'User1'
    password 'password'
  end
end

