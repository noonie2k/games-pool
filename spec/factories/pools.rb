# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pool do
    name "Some Test Pool"
    invite_code "a1b2c3d4"
  end
end
