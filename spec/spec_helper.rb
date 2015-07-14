require File.expand_path('../../lib/siteleaf.rb', __FILE__)
Dir['/lib/*.rb'].each { |file| require file }
require 'rspec'
require 'vcr'
require 'webmock/rspec'
require 'simplecov'
require 'figs'
Figs.load
SimpleCov.start

RSpec.configure do |_c|
  ENV['API_KEY'] ||= 'KEY' if  ENV['API_KEY'].nil?
  ENV['API_SECRET'] ||= 'SECRET' if ENV['API_SECRET'].nil?
  ENV['SITELEAF_ID'] ||= 'SITE_ID' if ENV['SITELEAF_ID'].nil?
  ENV['PAGE_ID'] ||= 'PAGE_ID' if ENV['PAGE_ID'].nil?
  ENV['POST_ID'] ||= 'POST_ID' if ENV['POST_ID'].nil?
  ENV['SUBPAGE_ID'] ||= 'SUBPAGE_ID' if ENV['SUBPAGE_ID'].nil?
end

VCR.configure do |config|
  config.default_cassette_options = { record: :new_episodes, match_requests_on: [:path] }
  config.cassette_library_dir     = 'spec/vcr_cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data('KEY') { ENV['API_KEY'] } unless ENV['API_KEY'].nil?
  config.filter_sensitive_data('SECRET') { ENV['API_SECRET'] } unless ENV['API_SECRET'].nil?
  config.filter_sensitive_data('SITE_ID') { ENV['SITELEAF_ID'] } unless ENV['SITELEAF_ID'].nil?
  config.filter_sensitive_data('PAGE_ID') { ENV['PAGE_ID'] } unless ENV['PAGE_ID'].nil?
  config.filter_sensitive_data('POST_ID') { ENV['POST_ID'] } unless ENV['POST_ID'].nil?
  config.filter_sensitive_data('SUBPAGE_ID') { ENV['SUBPAGE_ID'] } unless ENV['SUBPAGE_ID'].nil?
  # config.debug_logger = File.open('vcr_errors', 'w')
end
