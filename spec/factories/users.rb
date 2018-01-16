FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "#email-{n}@cookbook.com"
    end
    password 10203040
  end
end
