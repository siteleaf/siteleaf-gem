require File.expand_path('../../lib/siteleaf.rb', __FILE__)
Dir['/lib/*.rb'].each { |file| require file }
require 'webmock/rspec'
require 'simplecov'
SimpleCov.start
# To test online with real Siteleaf Site
WebMock.allow_net_connect!
# Defining these Environment Variables for RSpec tests and generalizing the ID's in all cases
ENV['ASSET_ID'] ||= 'ASSET_ID'
ENV['USER_ID'] ||= 'USER_ID'
ENV['SITE_ID'] ||= 'SITE_ID'
ENV['PAGE_ID'] ||= 'PAGE_ID'
ENV['POST_ID'] ||= 'POST_ID'
ENV['SUBPAGE_ID'] ||= 'SUBPAGE_ID'
ENV['PARENT_ID'] ||= 'PARENT_ID'
mocks ||= YAML.load_file(File.expand_path('../mocks.yml', __FILE__))
# Environment variables for SiteLeaf Objects
ENV['page'] ||= mocks['page']
ENV['post'] ||= mocks['post']
ENV['asset'] ||= mocks['asset']
ENV['user'] ||= mocks['user']
ENV['site'] ||= mocks['site']
ENV['error'] ||= mocks['error']
# Creating Arrays (name is plural)
ENV['assets'] ||= '[' + mocks['asset'] + ']'
ENV['posts'] ||= '[' + mocks['post'] + ']'
ENV['pages'] ||= '[' + mocks['page'] + ']'
ENV['users'] ||= '[' + mocks['user'] + ']'
ENV['sites'] ||= '[' + mocks['site'] + ']'
