FactoryGirl.define do
  factory :folder do
    sequence(:name) { |n| "Example name #{n}" }
    parent nil
    user
  end
end
