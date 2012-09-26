# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game do
    title 'Some Game'
    img_thumb_url 'http://www.example.com/thumb.png'
    img_tiny_url 'http://www.example.com/tiny_thumb.png'
    association :owner, factory: :existing_user

    after(:build) do |game|
      platform = FactoryGirl::create(:platform) rescue Platform.first
      game.platform = platform
    end
  end

  factory :game_with_same_title_and_platform, class: Game do
    title 'Some Game'
    img_thumb_url 'http://www.example.com/thumb.png'
    img_tiny_url 'http://www.example.com/tiny_thumb.png'
    association :owner, factory: :second_existing_user

    after(:build) do |game|
      platform = FactoryGirl::create(:platform) rescue Platform.first
      game.platform = platform
    end
  end
end