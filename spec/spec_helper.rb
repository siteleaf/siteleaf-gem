require File.expand_path('../../lib/siteleaf.rb', __FILE__)
Dir['/lib/*.rb'].each { |file| require file }
require 'rspec'
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
