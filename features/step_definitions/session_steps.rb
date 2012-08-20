### WHEN ###
When /^I log in with valid credentials$/ do
  visit login_path
  fill_in 'username', with: @user.username
  fill_in 'password', with: @user.password
  click_button 'Log In'
end

When /^I log in with an invalid password$/ do
  visit login_path
  fill_in 'username', with: @user.username
  fill_in 'password', with: 'This is not my password'
  click_button 'Log In'
end

When /^I log out$/ do
  visit logout_path
end

### THEN ###
Then /^I should be logged in$/ do
  page.should_not have_content('Log In')
  page.should_not have_content('Register')
end

Then /^I should be logged out$/ do
  page.should have_content('Log In')
  page.should have_content('Register')
end
