module Siteleaf
  class Page < Content

    def create_endpoint
      "sites/#{site_id}/pages"
    end
    
  end
end