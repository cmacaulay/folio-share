FactoryGirl.define do
  factory :user do
    first_name 'Alex'
    last_name 'Smith'
    password 'password'
    sequence(:cellphone) { |n| "303987#{n.to_s.rjust(4, '0')}" }
    sequence(:email) { |n| "alexsmith#{n}@example.com" }
    status 0
  end
end
