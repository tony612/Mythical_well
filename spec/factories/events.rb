include ActionDispatch::TestProcess
FactoryGirl.define do
  factory :event do
    sequence(:title) { |n| "Title#{n}" }
    sequence(:content) { |n| "Content#{n}" }
    location 'Local'
    start_date Time.now
    end_date Time.now
    sequence(:category) {['Life', 'Course', 'Speek'].sample}
    fee '0'
    image {fixture_file_upload(Rails.root.join(*%w[spec fixtures example.jpg]), "image/jpg")}
    association :user
    association :node, :factory => :school
    after(:build) { |e| e.tags << FactoryGirl.build(:tag) }
    after(:create) { |e| e.tags.each { |t| t.save! } }
  end
end
