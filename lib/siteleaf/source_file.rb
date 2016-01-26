module Siteleaf
  class SourceFile < Entity
    
    attr_accessor :file, :name, :site_id
    attr_reader :name, :url, :download_url, :type, :filesize, :sha, :created_at, :updated_at, :user_id
    
    def create_endpoint
      ::File.join("sites", site_id, "source", URI.escape(identifier))
    end
    
    def entity_endpoint
      create_endpoint
    end
    
    def identifier
      name
    end
    
    def to_file
      response = Client.get(::File.join("sites", site_id, "source", "#{URI.escape(identifier)}?download"))
      raise response['message'] if response['message'] # indicates API error
      response.body 
    end
    
  end
end