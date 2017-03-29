FactoryGirl.define do
  factory :upload do
    sequence(:name) { |n| "File #{n}" }
    content_type "application/pdf"
    size 200
    folder
  end
end
