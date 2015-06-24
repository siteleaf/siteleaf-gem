module Siteleaf
  class Job < Entity
  
    attr_reader :id
    
    def stream(&callback)
      HTTParty.send(:get, Siteleaf.api_url("jobs/#{self.id}"), {
        :basic_auth => {:username => Siteleaf.api_key, :password => Siteleaf.api_secret},
        :stream_body => true
      }) do |fragment|
        if str = fragment.match(/{.*}/)
          if json = JSON.parse(str[0])
            callback.call(json)
          end
        end
      end
    end
    
  end
end