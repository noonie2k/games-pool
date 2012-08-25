# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game do
    title 'Some Game'
    img_thumb_url 'http://www.example.com/thumb.png'
    img_tiny_url 'http://www.example.com/tiny_thumb.png'
    association :platform, factory: :platform
    association :owner, factory: :user
  end
end
