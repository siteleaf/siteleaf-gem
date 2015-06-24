module Siteleaf
  class Site < Entity

    attr_accessor :title, :domain, :timezone, :meta
    attr_reader :id, :user_id, :created_at, :updated_at
    
    def self.find_by_domain(domain)
      result = Client.get self.endpoint, {"domain" => domain}
      self.new(result.first) if result and result.size >= 1
    end
    
    def theme
      @theme ||= if result = Client.get("sites/#{self.id}/theme")
        theme = Theme.new(result)
        theme.site_id = self.id
        theme
      end
    end
    
    def assets
      result = Client.get "sites/#{self.id}/assets"
      result.map { |r| Asset.new(r) } if result
    end
    
    def pages
      result = Client.get "sites/#{self.id}/pages"
      result.map { |r| Page.new(r) } if result
    end
    
    def resolve(url = '/')
      Client.get "sites/#{self.id}/resolve", {"url" => url}
    end
    
    def preview(url = '/', template = nil)
      Client.post "sites/#{self.id}/preview", {"url" => url, "template" => template}
    end
    
    def publish
      result = Client.post "sites/#{self.id}/publish", {}
      Job.new(id: result.parsed_response["job_id"]) if result
    end
    
  end
end