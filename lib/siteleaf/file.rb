module Siteleaf
  class File < Entity
    
    attr_accessor :file, :filename, :path, :collection_path, :site_id, :user_id
    attr_reader :id, :name, :basename, :directory, :url, :download_url, :thumbnail_url, :content_type, :filesize, :sha, :created_at, :updated_at, :type
    
    def initialize(attributes = {})
      super(attributes)
      self.filename = name if self.filename.nil? # Files API uses name instead of filename
    end
    
    def update_endpoint
      ::File.join("sites", site_id, "files", URI.escape(filename))
    end
    
    def create_endpoint
      if collection_identifier && path
        ::File.join("sites", site_id, "collections", collection_identifier, "files")
      else
        update_endpoint
      end
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
    
    def identifier
      filename
    end
    
    def to_file
      response = Client.get(::File.join("sites", site_id, "files", "#{URI.escape(filename)}?download"))
      raise response['message'] if response['message'] # indicates API error
      response.body 
    end
    
  end
end