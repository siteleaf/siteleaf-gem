module Siteleaf
  class Content < Entity

    attr_accessor :title, :body, :path, :permalink, :visibility, :published_at, :user_id, :site_id, :metadata
    attr_reader :id, :filename, :basename, :directory, :url, :filesize, :sha, :published, :created_at, :updated_at
    
    def site
      Site.find(self.site_id) if self.site_id
    end
    
    def draft?
      !published?
    end
    
    def published?
      published != false
    end

    def to_file
      [frontmatter, "---\n\n".freeze, body].join('')
    end
  
    protected
  
    def frontmatter
      attrs = metadata || {}
      attrs['title'] = title
      attrs['date'] = Time.parse(published_at).utc.strftime('%F %T %z')
      attrs['published'] = false if draft?
      attrs['permalink'] = permalink unless permalink.nil?
  
      attrs.empty? ? "---\n".freeze : attrs.to_yaml
    end
    
  end
end