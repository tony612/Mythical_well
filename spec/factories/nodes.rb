# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :node do
    name "MyString"
    short_name "MyString"
    classify 'school'
  end
end
