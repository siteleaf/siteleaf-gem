module Siteleaf
  # Class to describe files
  class Asset < Entity
    attr_accessor :file, :filename, :replace, :site_id, :page_id, :post_id, :theme_id
    attr_reader :id, :url, :content_type, :filesize, :checksum, :created_at, :updated_at

    def create_endpoint
      if !post_id.nil?
        "posts/#{post_id}/assets"
      elsif !page_id.nil?
        "pages/#{page_id}/assets"
      elsif !theme_id.nil?
        "sites/#{site_id}/theme/assets"
      else
        "sites/#{site_id}/assets"
      end
    end

    def post
      Post.find(post_id) if post_id
    end

    def page
      Page.find(page_id) if page_id
    end

    def theme
      Theme.find(theme_id) if theme_id
    end

    def site
      Site.find(site_id) if site_id
    end
  end
end
