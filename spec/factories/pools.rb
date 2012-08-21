# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pool do
    name "Some Test Pool"
    password "poolpassword"
    password_confirmation "poolpassword"
  end
end
