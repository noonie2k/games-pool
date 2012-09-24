### THEN ###
Then /^I should be shown a notice with (.+)$/ do |message|
  case message
  when 'welcome'      then page.should have_content "Welcome to #{@pool.name}"
  when 'not a member' then page.should have_content 'You are not a member of the selected pool'
  when 'game created' then page.should have_content "#{@game.title} was created successfully"
  else raise 'Unknown message'
  end
end