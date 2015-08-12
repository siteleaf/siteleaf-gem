module Siteleaf
  class Upload < Asset

    def create_endpoint
      "sites/#{self.site_id}/uploads"
    end
    
  end
end