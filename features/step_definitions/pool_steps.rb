### GIVEN ###
Given /^There is an existing pool$/ do
  @pool = FactoryGirl::create(:pool)
end

### GIVEN ###
Given /^I am a member of the existing pool$/ do
  @pool.memberships.build({ user: @user })
  @pool.save
end

### WHEN ###
When /^I create a pool$/ do
  @pool = FactoryGirl::build(:pool)

  visit new_pool_path
  fill_in 'Name', with: @pool.name
  fill_in 'Password', with: @pool.password
  fill_in 'Repeat Password', with: @pool.password_confirmation
  click_button 'Create Pool'
end

When /^I click to join the existing pool$/ do
  visit pools_path
  click_link "join-#{@pool.id}"
end

When /^I enter a valid password$/ do
  fill_in 'password', with: @pool.password
  click_button 'Join'
end
  
When /^I enter an invalid password$/ do
  fill_in 'password', with: 'This is not the correct password'
  click_button 'Join'
end

### THEN ###
Then /^I should be shown a success message$/ do
  page.should have_content "Successfully created the pool #{@pool.name}"
end

Then /^I should be shown a successful join message$/ do
  page.should have_content "Welcome to #{@pool.name}"
end

Then /^I should be shown a failed join message with (.+)$/ do |message|
  case message
  when 'invalid password' then page.should have_content 'The password provided was invalid'
  when 'welcome back' then page.should have_content "Welcome back to #{@pool.name}"
  else raise 'Unknown Message'
  end
end

Then /^I should be shown a notice with (.+)$/ do |message|
  case message
  when 'welcome' then page.should have_content "Welcome to #{@pool.name}"
  when 'not a member' then page.should have_content 'You are not a member of the selected pool'
  else raise 'Unknown Message'
  end
end

Then /^I should (not )?be a member of the existing pool$/ do |not_a_member|
  members = @pool.members

  if not_a_member.nil?
    members.should include(@user)
  else
    members.should_not include(@user)
  end
end
