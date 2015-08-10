module Siteleaf
  # Encapsulates entore structure of site including page and posts
  class Site < Entity
    attr_accessor :title, :domain, :timezone, :meta
    attr_reader :id, :user_id, :created_at, :updated_at

    def self.find_by_domain(domain)
      result = Client.get endpoint, 'domain' => domain
      Site.new(result.first) if result && result.size >= 1
    end

    def theme
      result = Client.get("sites/#{id}/theme")
      theme = Theme.new(result)
      theme.site_id = id
      theme
    end

    def assets
      result = fetch_site_items('assets')
      result.map { |asset| Asset.new(asset) } if result
    end

    def pages
      result = fetch_site_items('pages')
      result.map { |page| Page.new(page) } if result
    end

    def posts
      result = fetch_site_items('posts')
      result.map { |post| Post.new(post) } if result
    end

    def resolve(url = '/')
      Client.get "sites/#{id}/resolve", 'url' => url
    end

    def preview(url = '/', template = nil)
      Client.post "sites/#{id}/preview", 'url' => url, 'template' => template
    end

    def fetch_site_items(item)
      Client.get "sites/#{id}/" + item
    end

    def publish
      result = Client.post "sites/#{id}/publish", {}
      Job.new(id: result.parsed_response['job_id']) if result
    end
  end
end
