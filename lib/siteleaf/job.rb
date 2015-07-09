module Siteleaf
  # Streaming jobs for siteleaf
  class Job < Entity
    attr_reader :id

    def jobs
      HTTParty.send(:get, Siteleaf.api_url("jobs/#{id}"),
                    basic_auth:  { username: Siteleaf.api_key,
                                   password: Siteleaf.api_secret,
                                   stream_body: true
                  })
    end

    def stream(&callback)
      jobs do |fragment|
        next if (str = fragment.match(/{.*}/)).nil?
        next if (json = JSON.parse(str[0])).nil?
        callback.call(json)
      end
    end
  end
end
