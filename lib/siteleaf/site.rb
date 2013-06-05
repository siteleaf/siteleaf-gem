module Siteleaf
  class Site < Entity

    attr_accessor :id, :title, :domain, :timezone, :user_id, :created_at, :updated_at
    protected :id=, :user_id=, :created_at=, :updated_at=
    
    def self.find_by_domain(domain)
      result = Client.get "sites", {"domain" => domain}
      self.new(result.first) if result and result.size >= 1
    end
    
    def pages
      result = Client.get "sites/#{self.id}/pages"
      result.map { |r| Page.new(r) } if result
    end
    
    def resolve(url = '/')
      Client.get "sites/#{self.id}/resolve", {"url" => url}
    end
    
    def preview(url = '/', template = nil)
      Client.post "sites/#{self.id}/preview.html", {"url" => url, "template" => template}
    end
    
  end
end