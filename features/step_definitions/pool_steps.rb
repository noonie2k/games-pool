### WHEN ###
When /^I create a pool with a password$/ do
  @pool = FactoryGirl::build(:pool)

  visit new_pool_path
  fill_in 'Name', with: @pool.name
  fill_in 'Password', with: @pool.password
  fill_in 'Repeat Password', with: @pool.password_confirmation
  click_button 'Create Pool'
end

### THEN ###
Then /^I should be shown a success message$/ do
  page.should have_content "Successfully created the pool #{@pool.name}"
end
