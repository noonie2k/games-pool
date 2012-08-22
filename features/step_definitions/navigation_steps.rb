### WHEN ###
When /^I go to (.+)$/ do |page|
  visit path_to(page)
end

### THEN ###
Then /^I should be on (.+)$/ do |_expected_page|
  current_path.should == path_to(_expected_page)
end

Then /^I should be redirected to (.+)$/ do |_expected_page|
  current_path.should == path_to(_expected_page)
end

