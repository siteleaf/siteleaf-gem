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
    
    def draft?
      visibility == 'draft'
    end
    
    def published?
      visibility == 'visible'
    end
    
    def to_file
      [frontmatter, "---\n\n".freeze, body].join('')
    end
  
    protected
  
    def frontmatter
      attrs = {}
      attrs['title'] = title
      attrs['date'] = Time.parse(published_at).utc.strftime('%F %T %z') unless published_at.nil?
      attrs['published'] = false if !published?
      
      meta.each{|m| attrs[m['key']] = m['value'].to_s.gsub("\r\n","\n")} unless meta.nil?
      
      if defined?(taxonomy) && !taxonomy.nil?
        taxonomy.each do |t| 
          attrs[t['key']] = t['values'].map{|v| v['value']} unless t['values'].empty?
        end 
      end
  
      attrs.empty? ? "---\n".freeze : attrs.to_yaml
    end
    
  end
end