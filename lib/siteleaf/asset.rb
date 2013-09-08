module Siteleaf
  class Asset < Entity

    attr_accessor :file, :filename, :replace, :site_id, :page_id, :post_id, :theme_id
    attr_reader :id, :url, :content_type, :filesize, :checksum, :created_at, :updated_at
    
    def create_endpoint
      if !self.post_id.nil?
        "posts/#{self.post_id}/assets"
      elsif !self.page_id.nil?
        "pages/#{self.page_id}/assets"
      elsif !self.theme_id.nil?
        "sites/#{self.site_id}/theme/assets"
      else
        "sites/#{self.site_id}/assets"
      end
    end
    
    def post
      Post.find(self.post_id) if self.post_id
    end
    
    def page
      Page.find(self.page_id) if self.page_id
    end
    
    def theme
      Theme.find(self.theme_id) if self.theme_id
    end
    
    def site
      Site.find(self.site_id) if self.site_id
    end
    
  end
end