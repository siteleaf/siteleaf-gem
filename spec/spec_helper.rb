require File.expand_path('../../lib/siteleaf.rb', __FILE__)
Dir['/lib/*.rb'].each { |file| require file }
require 'webmock/rspec'
require 'simplecov'
SimpleCov.start
# To test online with real Siteleaf Site
WebMock.allow_net_connect!
# Defining these Environment Variables for RSpec tests and generalizing the ID's in all cases
ASSET_ID ||= 'ASSET_ID'
USER_ID ||= 'USER_ID'
SITE_ID ||= 'SITE_ID'
PAGE_ID ||= 'PAGE_ID'
POST_ID ||= 'POST_ID'
SUBPAGE_ID ||= 'SUBPAGE_ID'
PARENT_ID ||= 'PARENT_ID'
mocks ||= YAML.load_file(File.expand_path('../mocks.yml', __FILE__))
# Environment variables for SiteLeaf Objects
PAGE ||= mocks['page']
ERROR ||= mocks['error']
# Creating Arrays (name is plural)
ASSETS ||= '[' + mocks['asset'] + ']'
POSTS ||= '[' + mocks['post'] + ']'
PAGES ||= '[' + mocks['page'] + ']'
USERS ||= '[' + mocks['user'] + ']'
SITES ||= '[' + mocks['site'] + ']'
