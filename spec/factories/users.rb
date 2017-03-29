FactoryGirl.define do
  factory :user do
    sequence(:first_name) { |n| "Michael#{n}" }
    last_name "Jackson"
    password "password"
    sequence(:cellphone) { |n| "303-987-#{n.to_s.rjust(4,"0")}" }
    sequence(:email) { |n| "doglover#{n}@example.com" }
    status 0
  end
end
