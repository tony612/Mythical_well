include ActionDispatch::TestProcess
FactoryGirl.define do
  factory :event do
    title 'This is a title'
    location 'Local'
    content 'This is a content'
    start_date Time.now
    end_date Time.now
    category 'Life'
    fee '0'
    image {fixture_file_upload(Rails.root.join(*%w[spec fixtures example.jpg]), "image/jpg")}
    association :user
    association :node
  end
end
