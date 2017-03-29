FactoryGirl.define do
  factory :user do
    first_name "Alex"
    last_name "Smith"
    password "password"
    cellphone "#{rand(100..999)}#{rand(0..999)}#{rand(000..9999)}"
    sequence(:cellphone) { |n| "303987#{n.to_s.rjust(4, "0")}" }
    sequence(:email) { |n| "alexsmith#{n}@example.com" }
    sequence(:username) { |n| "alexsmith#{n}" }
    status 0
  end
end
