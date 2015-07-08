require File.expand_path('../../lib/siteleaf.rb', __FILE__)
require File.expand_path('../../lib/siteleaf/asset.rb', __FILE__)
require File.expand_path('../../lib/siteleaf/client.rb', __FILE__)
require File.expand_path('../../lib/siteleaf/entity.rb', __FILE__)
require File.expand_path('../../lib/siteleaf/job.rb', __FILE__)
require File.expand_path('../../lib/siteleaf/page.rb', __FILE__)
require File.expand_path('../../lib/siteleaf/post.rb', __FILE__)
require File.expand_path('../../lib/siteleaf/server.rb', __FILE__)
require File.expand_path('../../lib/siteleaf/site.rb', __FILE__)
require File.expand_path('../../lib/siteleaf/theme.rb', __FILE__)
require File.expand_path('../../lib/siteleaf/user.rb', __FILE__)
require File.expand_path('../../lib/siteleaf/version.rb', __FILE__)
require 'vcr'
require 'webmock/rspec'

VCR.configure do |config|
  config.default_cassette_options = { record: :new_episodes, match_requests_on: [:path] }
  config.cassette_library_dir     = 'spec/vcr_cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.debug_logger = File.open('vcr_errors', 'w')
end
