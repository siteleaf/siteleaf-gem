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
    
    def frontmatter
      attrs = {}
      attrs['title'] = title
      attrs['date'] = Time.parse(published_at).utc unless published_at.nil?
      attrs['permalink'] = permalink unless permalink.nil?
      attrs['published'] = false if hidden?
      attrs.merge(metadata.to_hash)
    end

    def to_file
      attrs = frontmatter
      attrs_yaml = attrs.empty? ? "---\n".freeze : attrs.to_yaml
      attrs_yaml + "---\n\n".freeze + body.to_s
    end
    
  end
end