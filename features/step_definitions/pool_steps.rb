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
  visit new_pool_path
  fill_in 'Name', with: FactoryGirl::attributes_for(:pool)[:name]
  click_button 'Create Pool'

  @pool = Pool.last
end

When /^I click to join the existing pool$/ do
  visit pools_path
  click_link "join-#{@pool.id}"
end

When /^I enter a valid invite code/ do
  fill_in 'invite_code', with: @pool.invite_code
  click_button 'Join'
end

When /^I enter an invalid invite code/ do
  fill_in 'invite_code', with: 'not a valid invite code'
  click_button 'Join'
end
  
When /^I enter an invalid password$/ do
  fill_in 'invite_code', with: 'Not Exists'
  click_button 'Join'
end

### THEN ###
Then /^I should be shown the invite code$/ do
  page.should have_content @pool.invite_code
end

Then /^I should be shown a successful join message$/ do
  page.should have_content "Welcome to #{@pool.name}"
end

Then /^I should be shown a failed join message with (.+)$/ do |message|
  case message
  when 'invalid invite code' then page.should have_content 'The invite code provided was invalid'
  when 'welcome back' then page.should have_content "Welcome back to #{@pool.name}"
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
