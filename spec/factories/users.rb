FactoryGirl.define do
  factory :user do
    password "Passw0rd"
    password_confirmation { |u| u.password }

    sequence(:email) { |n| "test#{n}@example.com" }
  end
end
