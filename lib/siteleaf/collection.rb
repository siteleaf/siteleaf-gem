module Siteleaf
  class Collection < Entity

    attr_accessor :title, :path, :permalink, :output, :site_id, :user_id, :metadata
    attr_reader :id, :directory, :created_at, :updated_at
    
    def create_endpoint
      "sites/#{site_id}/collections"
    end
    
    def update_endpoint
      "sites/#{site_id}/collections/#{identifier}"
    end
    
    def identifier
      path
    end
    
    def site
      Site.find(site_id)
    end
    
    def documents
      result = Client.get "sites/#{site_id}/collections/#{identifier}/documents"
      result.map { |r| Document.new(r) } if result.is_a? Array
    end
    
    def files
      result = Client.get "sites/#{site_id}/collections/#{identifier}/files"
      result.map { |r| File.new(r) } if result.is_a? Array
    end
    
    def output?
      output == true
    end
    
    def filename
      path
    end
    
  end
end