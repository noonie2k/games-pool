require 'factory_girl'

FactoryGirl.define do
  factory :user do
    username 'someuser'
    name 'Some User'
    email 'someuser@somewhere.com'
    password 'secret'
    password_confirmation 'secret'
    admin false
  end

  factory :existing_user, class: User  do
    username 'someuser'
    name 'Some User'
    email 'someuser@somewhere.com'
    password 'secret'
    password_confirmation 'secret'
    admin false
  end
end
