module Siteleaf
  class Page < Entity

    attr_accessor :title, :body, :slug, :url, :parent_id, :site_id, :published_at, :meta
    attr_reader :id, :created_at, :updated_at
    
    def self.all
      result = Client.get "#{self.endpoint}"
      result.map { |r| self.new(r) } if result
    end
    
    def self.find(id)
      result = Client.get "#{self.endpoint}/#{id}"
      self.new(result) if result
    end
    
    def create_endpoint
      "sites/#{self.site_id}/pages"
    end
    
    def site
      Site.find(self.site_id) if self.site_id
    end
    
    def posts
      result = Client.get "pages/#{self.id}/posts"
      result.map { |r| Post.new(r) } if result
    end
    
    def pages
      result = Client.get "pages/#{self.id}/pages"
      result.map { |r| self.new(r) } if result
    end
    
    def page
      Page.find(self.parent_id) if self.parent_id
    end
    
  end
end