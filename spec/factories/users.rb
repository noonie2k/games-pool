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

  factory :second_user, class: User  do
    username 'seconduser'
    name 'Second User'
    email 'seconduser@somewhere.com'
    password 'secret'
    password_confirmation 'secret'
    admin false
  end
end
