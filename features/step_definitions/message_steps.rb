### THEN ###
Then /^I should be shown a notice with (.+)$/ do |message|
  case message
  when 'welcome'      then page.should have_content "Welcome to #{@pool.name}"
  when 'not a member' then page.should have_content 'You are not a member of the selected pool'
  when 'game created' then page.should have_content "#{@game.title} was created successfully"
  when 'game held'    then page.should have_content "A hold has been requested of #{@game.owner.name} for #{@game.title}"
  when 'already held' then page.should have_content "You have an existing hold on #{@game.title}"
  else raise 'Unknown message'
  end
end