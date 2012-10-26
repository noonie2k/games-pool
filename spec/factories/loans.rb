require 'factory_girl'

FactoryGirl.define do
  factory :loan do
    association :user, factory: :second_user
    association :game
  end
end
