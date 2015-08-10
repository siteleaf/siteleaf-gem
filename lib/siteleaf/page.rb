module Siteleaf
  # Encapsulates all Page Attributes and the posts and sub-page in a page
  class Page < Entity
    attr_accessor :title, :custom_slug, :body, :visibility, :published_at, :user_id, :site_id, :parent_id, :meta
    attr_reader :id, :slug, :url, :created_at, :updated_at, :assets

    def create_endpoint
      "sites/#{site_id}/pages"
    end

    def site
      Site.find(site_id) if site_id
    end

    def assets
      result = fetch_page_items('/assets')
      result.map { |asset| Asset.new(asset) } if result
    end

    def posts
      result = fetch_page_items('/posts')
      result.map { |post| Post.new(post) } if result
    end

    def pages
      result = fetch_page_items('?include=pages')
      result['pages'].map { |page| Page.new(page) } if result
    end

    def fetch_page_items(item)
      Client.get "pages/#{id}" + item
    end

    def page
      Page.find(parent_id) if parent_id
    end
  end
end
