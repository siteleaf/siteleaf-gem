require 'httmultiparty'

module Siteleaf
  class Client
    def self.auth(email, password)
      begin
        request = HTTParty.post(Siteleaf.api_url('auth'), {
          :basic_auth => {:username => email, :password => password},
          :headers => {"User-Agent" => "Siteleaf Gem/#{Siteleaf::VERSION}"}
        })
        return request.parsed_response # parse JSON
      rescue => e
        return 'error' => e.message # error
      end
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
      begin
        if (method == :post || method == :put) && !params.has_key?('file') && !params.has_key?(:file)
          request = HTTParty.send(method, Siteleaf.api_url(path), {
            :body => params.to_json,
            :basic_auth => {:username => Siteleaf.api_key, :password => Siteleaf.api_secret},
            :headers => {
              "Content-Type" => "application/json",
              "User-Agent" => "Siteleaf Gem/#{Siteleaf::VERSION}"
            },
            :timeout => 300
          })
        else
          request = HTTMultiParty.send(method, Siteleaf.api_url(path), {
            :query => params,
            :basic_auth => {:username => Siteleaf.api_key, :password => Siteleaf.api_secret},
            :headers => {"User-Agent" => "Siteleaf Gem/#{Siteleaf::VERSION}"},
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
