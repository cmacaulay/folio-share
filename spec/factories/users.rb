FactoryGirl.define do
  factory :user do
    sequence(:first_name) { |n| "Alex" }
    sequence(:last_name) { |n| "Smith" }
    password "password"
    sequence(:cellphone) { |n| "303987#{n.to_s.rjust(4,"0")}" }
    sequence(:email) { |n| "alexsmith#{n}@example.com" }
    status 0
  end
end
