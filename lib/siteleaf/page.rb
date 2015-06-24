module Siteleaf
  class Page < Entity

    attr_accessor :title, :custom_slug, :body, :visibility, :published_at, :user_id, :site_id, :parent_id, :meta
    attr_reader :id, :slug, :url, :created_at, :updated_at, :assets
    
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
      result = Client.get "pages/#{self.id}?include=pages"
      result["pages"].map { |r| Page.new(r) } if result
    end
    
    def page
      Page.find(self.parent_id) if self.parent_id
    end
    
  end
end