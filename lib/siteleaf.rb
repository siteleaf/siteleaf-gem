libdir = ::File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require 'siteleaf/version'
require 'siteleaf/client'
require 'siteleaf/entity'
require 'siteleaf/asset'
require 'siteleaf/file'
require 'siteleaf/upload'
require 'siteleaf/job'
require 'siteleaf/content'
require 'siteleaf/page'
require 'siteleaf/post'
require 'siteleaf/collection'
require 'siteleaf/document'
require 'siteleaf/site'
require 'siteleaf/user'
require 'patches/time_with_zone_encode_with'
require 'digest/sha1'
require 'rbconfig'
require 'uri'
require 'yaml'

module Siteleaf

  @api_key = ENV['SITELEAF_API_KEY']
  @api_secret = ENV['SITELEAF_API_SECRET']
  @api_base = 'https://api.v2.siteleaf.com'
  @api_version = 'v2'

  class << self
    attr_accessor :api_key, :api_secret, :api_base, :api_version
  end

  def self.api_url(url = '')
    ::File.join(@api_base, @api_version, url)
  end

  def self.settings_file
    ::File.expand_path('~/.siteleaf.yml')
  end

  def self.load_settings(file = self.settings_file)
    if ::File.exist?(file)
      settings = ::File.open(file) { |f| YAML.load(f) }
      
      [:api_key, :api_secret, :api_base, :api_version].each do |key|
        self.send "#{key}=", settings[key.to_s] if settings.has_key?(key.to_s)
      end
        
      symbolized_settings = Hash.new
      settings.each{|k,v| symbolized_settings[k.to_sym] = v}
      
      symbolized_settings
    end
  rescue 
    nil
  end
  
  def self.save_settings(settings, file = self.settings_file)
    stringified_settings = Hash.new
    settings.each{|k,v| stringified_settings[k.to_s] = v}
    
    ::File.open(file, 'w') { |f| f.write stringified_settings.to_yaml }
    
    settings
  end

end