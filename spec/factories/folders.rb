FactoryGirl.define do
  factory :folder do
    sequence(:name) { |n| "Folder #{n}" }
    is_private true
    parent nil
    user
  end
end
