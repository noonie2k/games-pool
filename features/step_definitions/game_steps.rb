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
