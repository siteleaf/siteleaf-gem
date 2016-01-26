module Siteleaf
  class File < Entity
    
    attr_accessor :file, :filename, :path, :collection_path, :site_id, :user_id
    attr_reader :id, :basename, :directory, :url, :download_url, :thumbnail_url, :content_type, :filesize, :sha, :created_at, :updated_at
    
    def create_endpoint
      ::File.join("sites", site_id, "collections", collection_identifier, "files")
    end
    
    def site
      Site.find(site_id) if site_id
    end
    
    def collection
      Collection.find(collection_identifier)
    end
    
    def collection_identifier
      collection_path || (directory && directory.match(/_(.*)/).try(:last))
    end
    
    def to_file
      SourceFile.new(site_id: site_id, name: filename).to_file
    end
    
  end
end