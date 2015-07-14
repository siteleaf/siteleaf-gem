require File.expand_path('../../lib/siteleaf.rb', __FILE__)
Dir["/lib/*.rb"].each { |file| require file }
require 'vcr'
require 'webmock/rspec'

VCR.configure do |config|
  config.default_cassette_options = { record: :new_episodes, match_requests_on: [:path] }
  config.cassette_library_dir     = 'spec/vcr_cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  # config.debug_logger = File.open('vcr_errors', 'w')
end
