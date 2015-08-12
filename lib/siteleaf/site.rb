module Siteleaf
  class Site < Entity

    attr_accessor :title, :domain, :timezone, :metadata
    attr_reader :id, :user_id, :created_at, :updated_at
    
    def self.find_by_domain(domain)
      result = Client.get self.endpoint, {"domain" => domain}
      self.new(result.first) if result and result.size >= 1
    end
    
    def files
      result = Client.get "sites/#{self.id}/files"
      result.map { |r| File.new(r) } if result
    end
    
    def uploads
      result = Client.get "sites/#{self.id}/uploads"
      result.map { |r| Upload.new(r) } if result
    end
    
    def pages
      result = Client.get "sites/#{self.id}/pages"
      result.map { |r| Page.new(r) } if result
    end
    
    def posts
      result = Client.get "sites/#{self.id}/posts"
      result.map { |r| Post.new(r) } if result
    end
    
    def collections
      result = Client.get "sites/#{self.id}/collections"
      result.map { |r| Collection.new(r) } if result
    end
    
    def publish
      result = Client.post "sites/#{self.id}/publish", {}
      Job.new(id: result.parsed_response["job_id"]) if result
    end
    
  end
end