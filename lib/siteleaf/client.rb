require 'httmultiparty'

module Siteleaf
  class Client
    def self.auth(email, password)
      begin
        request = HTTParty.post(Siteleaf.api_url('auth'), {
          :basic_auth => {:username => email, :password => password}
        })
        return request.parsed_response # parse JSON
      rescue => e
        return 'error' => e.message # error
      end
    end

    def self.get(path, params = {})
      params['limit'] = 9999
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
      begin
        if (method == :post || method == :put) && !params.has_key?('file')
          request = HTTParty.send(method, Siteleaf.api_url(path), {
            :headers => { 'Content-Type' => 'application/json' },
            :body => params.to_json,
            :basic_auth => {:username => Siteleaf.api_key, :password => Siteleaf.api_secret},
            :timeout => 300
          })
        else
          request = HTTMultiParty.send(method, Siteleaf.api_url(path), {
            :query => params,
            :basic_auth => {:username => Siteleaf.api_key, :password => Siteleaf.api_secret},
            :timeout => 300
          })
        end
        if request.respond_to?('parsed_response')
          return request.parsed_response # parse JSON
        else
          return request # raw
        end
      rescue => e
        return 'error' => e.message # error
      end
    end
  end
end
