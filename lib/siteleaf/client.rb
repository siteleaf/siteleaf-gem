require 'httmultiparty'

module Siteleaf
  # Class to define Current User
  class Client
    def self.auth(email, password)
      request = HTTParty.post(Siteleaf.api_url('auth'), basic_auth: { username: email, password: password })
      return request.parsed_response # parse JSON
      rescue => e
        return 'error' => e.message # error
    end

    def self.get(path, params = nil)
      execute(:get, path, params)
    end

    def self.post(path, params)
      execute(:post, path, params)
    end

    def self.put(path, params)
      execute(:put, path, params)
    end

    def self.delete(path, params = nil)
      execute(:delete, path, params)
    end

    def self.request(method, path, params)
      HTTMultiParty.send(method,
                         Siteleaf.api_url(path),
                         query: params,
                         basic_auth: { username: Siteleaf.api_key, password: Siteleaf.api_secret },
                         timeout:  300
                        )
    end

    def self.execute(method, path, params = nil)
      Siteleaf.load_settings unless Siteleaf.api_key
      req = request(method, path, params)
      if req.respond_to?('parsed_response')
        return req.parsed_response # parse JSON
      else
        return req # raw
      end
      rescue => e
        return 'error' => e.message # error
    end
  end
end
