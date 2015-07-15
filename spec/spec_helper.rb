require File.expand_path('../../lib/siteleaf.rb', __FILE__)
Dir['/lib/*.rb'].each { |file| require file }
require 'rspec'
require 'vcr'
require 'webmock/rspec'
require 'simplecov'
SimpleCov.start

RSpec.configure do |_c|
  ENV['API_KEY'] ||= 'KEY'
  ENV['API_SECRET'] ||= 'SECRET'
  ENV['SITELEAF_ID'] ||= 'SITE_ID'
  ENV['PAGE_ID'] ||= 'PAGE_ID'
  ENV['POST_ID'] ||= 'POST_ID'
  ENV['SUBPAGE_ID'] ||= 'SUBPAGE_ID'
  ENV['PARENT_ID'] ||= 'PARENT_ID'
end

VCR.configure do |config|
  config.default_cassette_options = { record: :new_episodes, match_requests_on: [:path] }
  config.cassette_library_dir     = 'spec/vcr_cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
end
