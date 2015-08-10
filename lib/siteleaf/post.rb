module Siteleaf
  # Encapsulates the single unique page attribute i.e. tags and inherits the rest from Page
  class Post < Page
    attr_accessor :taxonomy

    def create_endpoint
      "pages/#{parent_id}/posts"
    end

    def parent
      Page.find(parent_id)
    end

    def assets
      result = Client.get "posts/#{id}/assets"
      result.map { |asset| Asset.new(asset) } if result
    end
  end
end
