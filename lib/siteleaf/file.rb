module Siteleaf
  class File < Asset

    def create_endpoint
      "sites/#{self.site_id}/files"
    end
    
  end
end