module Siteleaf
  class Collection < Entity

    attr_accessor :title, :path, :output, :site_id, :metadata
    attr_reader :id, :basename, :directory, :created_at, :updated_at
    
    def create_endpoint
      "sites/#{self.site_id}/collections"
    end
    
    def site
      Site.find(self.site_id)
    end
    
    def documents
      result = Client.get "collections/#{self.id}/documents"
      result.map { |r| Document.new(r) } if result
    end
    
  end
end