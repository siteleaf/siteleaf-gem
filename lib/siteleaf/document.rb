module Siteleaf
  class Document < Content

    attr_accessor :collection_id
    
    def create_endpoint
      "collections/#{self.collection_id}/documents"
    end
    
    def collection
      Collection.find(self.collection_id)
    end
    
  end
end