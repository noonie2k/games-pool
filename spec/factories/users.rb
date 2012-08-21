# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :existing_user, class: User do
    username 'existinguser'
    email 'some.existing.user@home.com'
    name 'Some Existing User'
    password 'password'
    password_confirmation 'password'
  end

  factory :user do
    username 'someuser'
    email 'some.user@home.com'
    name 'Some User'
    password 'password'
    password_confirmation 'password'
  end
end
