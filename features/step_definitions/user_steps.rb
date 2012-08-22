### GIVEN ###
Given /^I am a visitor visiting the site$/ do
  @visitor = FactoryGirl::build(:user)
end

Given /^I have a registered account$/ do
  @user = FactoryGirl::create(:user)
end

Given /^I am logged in$/ do
  steps %Q{ When I log in with valid credentials }
end

Given /^I am logged out$/ do
  visit logout_path
end

### WHEN ###
When /^I register with valid information$/ do
  visit new_user_path
  fill_in 'Username', with: @visitor.username
  fill_in 'Name', with: @visitor.name
  fill_in 'Email', with: @visitor.email
  fill_in 'Password', with: @visitor.password
  fill_in 'Repeat Password', with: @visitor.password_confirmation
  click_button 'Register'
end

When /^I register with missing (.+)$/ do |attribute|
  @visitor.send("#{attribute}=", '')

  visit new_user_path
  fill_in 'Username', with: @visitor.username
  fill_in 'Name', with: @visitor.name
  fill_in 'Email', with: @visitor.email
  fill_in 'Password', with: @visitor.password
  fill_in 'Repeat Password', with: @visitor.password_confirmation
  click_button 'Register'
end

When /^I register with mismatched password$/ do
  visit new_user_path
  fill_in 'Username', with: @visitor.username
  fill_in 'Name', with: @visitor.name
  fill_in 'Email', with: @visitor.email
  fill_in 'Password', with: @visitor.password
  fill_in 'Repeat Password', with: 'This is not my password'
  click_button 'Register'
end

### THEN ###
Then /^I should be shown a welcome message$/ do
  page.should have_content("Welcome #{@visitor.name}")
end

Then /^I should be shown an invalid entry message$/ do
  page.should have_content('Please review the problems below:')
end

Then /^I should have a user account$/ do
  User.find_by_username(@visitor.username).should_not be_nil
end

Then /^I should not have a user account$/ do
  User.find_by_username(@visitor.username).should be_nil
end
