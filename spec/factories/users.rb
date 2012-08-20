# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username 'someuser'
    email 'some.user@home.com'
    name 'Some User'
    password 'password'
    password_confirmation 'password'
  end
end
