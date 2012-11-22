FactoryGirl.define do
  factory :tag do
    sequence(:name) { ['tag1', 'tag2', 'tag3'].sample }
  end
end
