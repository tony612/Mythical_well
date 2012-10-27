require 'factory_girl'
FactoryGirl.define do
  factory :user do
    username 'username'
    email 'test@test.com'
    name 'User1'
    password 'password'
  end

  factory :event do
    title 'This is a title'
    content 'This is a content'
    start_date Time.now
    end_date Time.now
    category 'Life'
    fee '0'
  end
end

