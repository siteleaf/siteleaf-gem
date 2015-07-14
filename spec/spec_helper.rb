require File.expand_path('../../lib/siteleaf.rb', __FILE__)
Dir["/lib/*.rb"].each { |file| require file }
require 'vcr'
require 'webmock/rspec'

VCR.configure do |config|
  config.default_cassette_options = { record: :new_episodes, match_requests_on: [:path] }
  config.cassette_library_dir     = 'spec/vcr_cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data('KEY') { ENV['API_KEY'] } unless ENV['API_KEY'].nil?
  config.filter_sensitive_data('SECRET') { ENV['API_SECRET'] } unless ENV['API_SECRET'].nil?
  config.filter_sensitive_data('ID') { ENV['SITELEAF_ID'] } unless ENV['SITELEAF_ID'].nil?
  config.filter_sensitive_data('ID') { ENV['PAGE_ID'] } unless ENV['PAGE_ID'].nil?
  config.filter_sensitive_data('ID') { ENV['POST_ID'] } unless ENV['POST_ID'].nil?
  config.filter_sensitive_data('ID') { ENV['SUBPAGE_ID'] } unless ENV['SUBPAGE_ID'].nil?
  # config.debug_logger = File.open('vcr_errors', 'w')
end
