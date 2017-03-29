FactoryGirl.define do
  factory :folder do
    sequence(:name) { |n| "Folder #{n}" }
    parent nil
    user
  end
end
