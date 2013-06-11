require 'rest-client'
require 'json'

module Siteleaf
  class Client  
    def self.auth(email, password)
      request = RestClient::Request.new(:url => Siteleaf.api_url('auth'), :method => :post, :user => email, :password => password)
      begin
        response = request.execute
        return JSON.parse(response) # parse JSON
      rescue => e
        return e.inspect # error
      end
    end
  
    def self.get(path, params = nil)
      self.execute(:get, path, params)
    end
    
    def self.post(path, params)
      self.execute(:post, path, params)
    end
    
    def self.put(path, params)
     self.execute(:put, path, params)
    end
    
    def self.delete(path, params = nil)
      self.execute(:delete, path, params)
    end
    
    def self.execute(method, path, params = nil)
      Siteleaf.load_settings if !Siteleaf.api_key
      request = RestClient::Request.new(:url => Siteleaf.api_url(path), :method => method, :payload => params, :user => Siteleaf.api_key, :password => Siteleaf.api_secret)
      #begin
        response = request.execute
        if response.headers[:content_type].to_s.include?('json')
          return JSON.parse(response) # parse JSON
        else
          return response # raw
        end
      #rescue => e
      #  return e.inspect # error
      #end
    end
  end
end