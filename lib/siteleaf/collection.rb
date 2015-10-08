module Siteleaf
  class Collection < Entity

    attr_accessor :title, :path, :permalink, :output, :site_id, :metadata
    attr_reader :id, :directory, :created_at, :updated_at
    
    def create_endpoint
      "sites/#{self.site_id}/collections"
    end
    
    def site
      Site.find(self.site_id)
    end
    
    def documents
      result = Client.get "collections/#{self.id}/documents"
      result.map { |r| Document.new(r) } if result.is_a? Array
    end
    
    def output?
      output == true
    end
    
    def filename
      path
    end
    
  end
end