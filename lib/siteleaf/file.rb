module Siteleaf
  class File < Asset
    
    attr_accessor :collection_path

    def create_endpoint
      if collection_identifier
        "sites/#{site_id}/collections/#{collection_identifier}/files"
      else
        "sites/#{site_id}/files/#{path}"
      end
    end
    
    def collection
      Collection.find(collection_identifier)
    end
    
    def collection_identifier
      collection_path || directory.match(/_(.*)/).try(:last)
    end
    
  end
end