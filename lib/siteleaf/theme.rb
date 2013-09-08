module Siteleaf
  class Theme < Entity

    attr_accessor :name, :site_id
    attr_reader :id, :created_at, :updated_at
    
    def self.find_by_site_id(site_id)
      Site.new({:id => site_id}).theme
    end
    
    def self.assets_by_site_id(site_id)
      Theme.new({:site_id => site_id}).assets
    end
    
    def site
      Site.find(self.site_id)
    end
    
    def assets
      result = Client.get "sites/#{self.site_id}/theme/assets"
      result.map { |r| Asset.new(r) } if result
    end
    
  end
end