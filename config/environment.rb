# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
GamesPool::Application.initialize!

# Use RemoteLinkRenderer for AJAX pagination
WillPaginate::ViewHelpers.pagination_options[:renderer] = 'RemoteLinkRenderer'