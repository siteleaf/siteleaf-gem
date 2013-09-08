module Siteleaf
  class Post < Page

    attr_accessor :taxonomy
    
    def create_endpoint
      "pages/#{self.parent_id}/posts"
    end
    
    def parent
      Page.find(self.parent_id)
    end
    
    def assets
      result = Client.get "posts/#{self.id}/assets"
      result.map { |r| Asset.new(r) } if result
    end
    
  end
end