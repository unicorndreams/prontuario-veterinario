FactoryBot.define do
  factory :user, class: "User" do
    sequence(:email) { |n| "jose#{n}@gmail.com" }
    password { "12345678" }
  end
end