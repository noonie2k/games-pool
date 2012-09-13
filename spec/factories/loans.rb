# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :loan do
    user nil
    game nil
    status "MyString"
  end
end
