FactoryGirl.define do
  factory :user do
    first_name "Alex"
    last_name "Smith"
    password "password"
    sequence(:cellphone) { |n| "3039#{n.to_s.rjust(6, "0")}" }
    sequence(:email) { |n| "alexsmith#{n}@example.com" }
    sequence(:username) { |n| "alexsmith#{n}" }
    status 0
  end
end
