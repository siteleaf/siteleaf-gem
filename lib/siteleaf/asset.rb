module Siteleaf
  class Asset < Entity

    attr_accessor :file, :filename, :path, :basename, :directory, :permalink, :replace, :site_id, :metadata
    attr_reader :id, :basename, :directory, :url, :content_type, :filesize, :sha, :static, :created_at, :updated_at
    
    def site
      Site.find(self.site_id) if self.site_id
    end
    
    def filename
      (directory == '.') ? basename : ::File.join(directory, basename)
    end
    
    def frontmatter
      attrs = {}
      attrs['permalink'] = permalink unless permalink.nil?
      attrs.merge(metadata.to_hash)
    end
    
    def to_file
      if static?
        body
      else
        attrs = frontmatter
        attrs_yaml = attrs.empty? ? "---\n".freeze : attrs.to_yaml
        attrs_yaml + "---\n\n".freeze + body
      end
    end
    
    def body
      open(file['url'], 'r:UTF-8') { |f| f.read }
    end
    
    def static?
      static == true
    end
    
  end
end