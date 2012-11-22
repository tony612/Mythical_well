FactoryGirl.define do
  factory :node do
    sequence(:name) { |n| "City#{n}"}
    sequence(:short_name) { |n| "city#{n}"}
    classify 'city'
  end

  factory :school, :class => Node do
    sequence(:name) { |n| "School#{n}"}
    sequence(:short_name) { |n| "school#{n}"}
    classify 'school'
  end
end
