module Siteleaf
  # Class to encapsulate the theme files of any siteleaf site
  class Theme < Entity
    attr_accessor :name, :site_id
    attr_reader :id, :created_at, :updated_at

    def self.find_by_site_id(site_id)
      Site.new(id: site_id).theme
    end

    def self.assets_by_site_id(site_id)
      Theme.new(site_id: site_id).assets
    end

    def site
      Site.find(site_id)
    end

    def assets
      result = Client.get "sites/#{site_id}/theme/assets"
      result.map { |asset| Asset.new(asset) } if result
    end
  end
end
