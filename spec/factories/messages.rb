# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    content ""
    user_id ""
    is_read false
  end
end
