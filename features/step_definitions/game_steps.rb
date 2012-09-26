### GIVEN ###
Given /^There are existing games$/ do
  FactoryGirl::create(:game)
  FactoryGirl::create(:game_with_same_title_and_platform)
end

Given /^I have a hold on the (first|last) game$/ do |position|
  Game.send(position).loans.create({ user: @user })
end

### WHEN ###
When /^I create a game$/ do
  platform = FactoryGirl::create(:platform)
  game = FactoryGirl::attributes_for(:game)

  visit '/games/new'
  fill_in 'game_title', with: game[:title]
  select platform.name, from: 'game_platform_id'
  fill_in 'game_img_thumb_url', with: game[:img_thumbnail_url]
  fill_in 'game_img_tiny_url', with: game[:img_tiny_url]
  click_button 'Create Game'

  @game = Game.last
end

When /^I request a hold on the (first|last) game$/ do |position|
  click_link 'Place Hold'

  @game = Game.send(position)
end
