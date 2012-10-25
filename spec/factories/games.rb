require 'factory_girl'

FactoryGirl.define do
  factory :game do
    title 'Some Game'
    img_thumb_url 'http://www.example.com/images/somegame_m.jpg'
    img_tiny_url 'http://www.example.com/images/somegame_s.jpg'

    association :platform, factory: :platform
    association :owner, factory: :user
  end
end
