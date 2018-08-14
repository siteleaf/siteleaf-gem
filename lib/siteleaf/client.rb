require 'httparty'

module Siteleaf
  class Client
    def self.auth(email, password)
      request = HTTParty.post(Siteleaf.api_url('auth'), {
        :basic_auth => {:username => email, :password => password},
        :headers => {"User-Agent" => "Siteleaf Gem/#{Siteleaf::VERSION}"}
      })
      response = request.parsed_response
      if response.is_a?(Hash) && error = response['message'] || response['error']
        raise error
      end
      response
    end

    def self.get(path, params = {})
      params['per_page'] = 9999 # todo: paginate
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
      
      options = {
        :basic_auth => {:username => Siteleaf.api_key, :password => Siteleaf.api_secret},
        :headers => {"User-Agent" => "Siteleaf Gem/#{Siteleaf::VERSION}"},
        :timeout => 300
      }
      
      if method == :get || method == :delete
        options[:query] = params
      elsif params.has_key?('file') || params.has_key?(:file)
        options[:body] = params
      else
        options[:body] = params.to_json
        options[:headers]["Content-Type"] = "application/json"
      end
      
      request = HTTParty.send(method, Siteleaf.api_url(path), options)
      response = request.parsed_response
      if response.is_a?(Hash) && error = response['message'] || response['error']
        raise error
      end
      response
    end
  end
end
