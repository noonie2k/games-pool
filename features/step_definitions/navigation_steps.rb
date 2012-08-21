### WHEN ###
When /^I go to (.+)$/ do |page|
  visit path_to(page)
end

### THEN ###
Then /^I should be redirected to (.+)$/ do |page|
  current_path.should == path_to(page)
end

