libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require 'siteleaf/version'
require 'siteleaf/client'
require 'siteleaf/entity'
require 'siteleaf/asset'
require 'siteleaf/job'
require 'siteleaf/page'
require 'siteleaf/post'
require 'siteleaf/server'
require 'siteleaf/site'
require 'siteleaf/theme'
require 'siteleaf/user'
require 'patches/time_with_zone_encode_with'
require 'rbconfig'
require 'uri'
require 'yaml'

module Siteleaf

  @api_base = 'https://api.siteleaf.com/v1'

  class << self
    attr_accessor :api_key, :api_secret, :api_base
  end

  def self.api_url(url='')
    "#{@api_base}/#{url}"
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
      
    # read legacy settings, upgrade old marshal format into yaml
    elsif self.load_legacy_settings
      symbolized_settings = {api_key: self.api_key, api_secret: self.api_secret}
      self.save_settings(symbolized_settings)
      ::File.unlink(self.legacy_settings_file)
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
  
  # here for v1 legacy purposes
  def self.legacy_settings_file
    ::File.expand_path('~/.siteleaf')
  end
  
  def self.load_legacy_settings
    if ::File.exist?(legacy_settings_file)
      config = ::File.open(legacy_settings_file) do|file|
        Marshal.load(file)
      end
      self.api_key = config[:api_key] if config.has_key?(:api_key)
      self.api_secret = config[:api_secret] if config.has_key?(:api_secret)
    end
  end

end