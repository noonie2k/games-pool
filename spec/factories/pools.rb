require 'factory_girl'

FactoryGirl.define do
  factory :pool do
    name 'Pool A'
  end

  factory :second_pool, class: Pool do
    name 'Pool B'
  end
end
