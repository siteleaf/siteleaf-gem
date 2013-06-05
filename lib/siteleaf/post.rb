module Siteleaf
  class Post < Page

    attr_accessor :taxonomy
    
    def create_endpoint
      "pages/#{self.parent_id}/posts"
    end
    
    def parent
      Page.find(self.parent_id)
    end
    
  end
end