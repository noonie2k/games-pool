# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :existing_user, class: User do
    username 'existinguser'
    email 'some.existing.user@home.com'
    name 'Some Existing User'
    password 'password'
    password_confirmation 'password'
    admin false
  end

  factory :admin, class: User do
    username 'admin'
    email 'some.admin@home.com'
    name 'Some Admin'
    password 'secret'
    password_confirmation 'secret'
    admin true
  end

  factory :user do
    username 'someuser'
    email 'some.user@home.com'
    name 'Some User'
    password 'password'
    password_confirmation 'password'
    admin false
  end
end
