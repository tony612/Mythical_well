FactoryGirl.define do
  factory :comment do
    content 'Content'
    association :user
    association :event
  end
end
