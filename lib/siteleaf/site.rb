module Siteleaf
  class Site < Entity

    attr_accessor :title, :domain, :timezone, :meta, :posts_path, :version
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

    def posts
      result = Client.get "sites/#{self.id}/posts"
      result.map { |r| Post.new(r) } if result
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

    def posts_path
      @posts_path || 'posts'
    end

    def filename
      "_config.yml"
    end

    def config
      attrs = {}
      attrs['title'] = title
      attrs['url'] = "http://#{domain}"
      attrs['timezone'] = timezone
      attrs['permalink'] = 'pretty'
      attrs['markdown'] = 'kramdown'

      meta.each{|m| attrs[m['key'].to_s.downcase] = m['value'].to_s == '' ? nil : m['value'].to_s.gsub("\r\n","\n")} unless meta.nil?

      # output uploads using v1 /assets path
      attrs['collections'] = {
        'uploads' => {
          'title' => 'Uploads',
          'output' => true
        }
      }

      # use collections for any set of posts not called "posts"
      pages.each do |page|
        path = page.url.sub('/','').gsub('/','_')
        if path != posts_path && page.posts.size > 0
          attrs['collections'][path] = {'output' => true}
          # output permalink for non-standard urls (e.g. posts inside sub-pages)
          attrs['collections'][path]['permalink'] = "#{page.url}/:path" if path != page.slug
        end
      end

      # set permalink style for posts
      attrs['defaults'] = [{
        'scope' => {
          'path' => '',
          'type' => 'posts'
        },
        'values' => {
          'permalink' => "/#{posts_path}/:title/"
        }
      }]

      attrs
    end

    def to_file(dir = 'export')
      assets = Dir.glob("#{dir}/_uploads/**/*").each_with_object({}) do |var, hash|
        # remap assets to _uploads
        hash[var.sub("#{dir}/_uploads",'/assets')] = var.sub("#{dir}/_uploads",'/uploads')
      end

      config.to_yaml.gsub(Regexp.union(assets.keys), assets)
    end

  end
end