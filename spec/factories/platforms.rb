require 'factory_girl'

FactoryGirl.define do
  factory :platform do
    color_code '#ccc'
    name 'Some Platfom'
  end

  factory :second_platform, class: Platform do
    color_code '#ddd'
    name 'Second Platfom'
  end
end
