FactoryBot.define do
  factory :user do
    sequence :email do |n|
    "user-#{n}@cookbook.com"
  end
    password 10203040
  end
end
