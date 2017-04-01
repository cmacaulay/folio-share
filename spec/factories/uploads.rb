FactoryGirl.define do
  factory :upload do
    sequence(:name) { |n| "File #{n}" }
    content_type "application/pdf"
    size 200
    folder
    attachment "/spec/fixtures/elephant.jpg"
  end
end
