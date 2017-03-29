FactoryGirl.define do
  factory :upload do
    sequence(:name) { |n| "File #{n}" }
    folder
  end
end
