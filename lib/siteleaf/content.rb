module Siteleaf
  class Content < Entity

    attr_accessor :title, :body, :path, :permalink, :visibility, :published_at, :user_id, :site_id, :metadata
    attr_reader :id, :filename, :basename, :directory, :url, :filesize, :sha, :published, :created_at, :updated_at
    
    def site
      Site.find(self.site_id) if self.site_id
    end
    
    def draft?
      visibility == 'draft'
    end
    
    def hidden?
      visibility == 'hidden'
    end
    
    def visible?
      visibility == 'visible'
    end
    alias_method :published?, :visible?

    def to_file
      frontmatter + "---\n\n".freeze + body.to_s
    end
  
    protected
  
    def frontmatter
      attrs = metadata || {}
      attrs['title'] = title
      attrs['date'] = Time.parse(published_at).utc unless published_at.nil?
      attrs['published'] = false if hidden?
      attrs['permalink'] = permalink unless permalink.nil?
  
      attrs.empty? ? "---\n".freeze : attrs.to_yaml
    end
    
  end
end