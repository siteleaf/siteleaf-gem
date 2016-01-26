module Siteleaf
  class Content < Entity

    attr_accessor :title, :body, :path, :permalink, :visibility, :date, :user_id, :site_id, :metadata
    attr_reader :id, :filename, :basename, :directory, :url, :sha, :created_at, :updated_at
    
    def site
      Site.find(site_id) if site_id
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
      SourceFile.new(site_id: site_id, name: filename).to_file
    end
    
  end
end