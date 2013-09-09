module Siteleaf
  class Page < Entity

    attr_accessor :title, :body, :custom_slug, :url, :parent_id, :site_id, :published_at, :user_id, :meta, :assets
    attr_reader :id, :slug, :created_at, :updated_at
    
    def create_endpoint
      "sites/#{self.site_id}/pages"
    end
    
    def site
      Site.find(self.site_id) if self.site_id
    end
    
    def assets
      result = Client.get "pages/#{self.id}/assets"
      result.map { |r| Asset.new(r) } if result
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