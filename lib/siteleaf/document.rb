module Siteleaf
  class Document < Content

    attr_accessor :collection_path
    
    def create_endpoint
      "sites/#{site_id}/collections/#{collection_identifier}/documents"
    end
    
    def collection
      Collection.find(collection_identifier)
    end
    
    def collection_identifier
      collection_path || directory.match(/_(.*)/).try(:last)
    end
    
  end
end