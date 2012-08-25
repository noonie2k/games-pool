### WHEN ###
When /^I create a game$/ do
  @game = FactoryGirl::build(:game)

  visit '/games/new'
  fill_in 'Title', with: @game.Title
  fill_in 'Platform', with: @platform.id
  fill_in 'Thumbnail URL', with: @game.img_thumbnail_url
  fill_in 'Tiny Thumbnail URL', with: @game.img_tiny_url
  click_button 'Create Game'
end
