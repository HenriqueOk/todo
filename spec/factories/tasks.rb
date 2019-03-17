# This will guess the User class
FactoryBot.define do
  factory :task do
    description { 'Task description' }
    association :user
  end
end
