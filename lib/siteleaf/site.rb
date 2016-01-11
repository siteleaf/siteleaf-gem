module Siteleaf
  class Site < Entity

    attr_accessor :title, :domain, :timezone, :metadata, :defaults
    attr_reader :id, :user_id, :created_at, :updated_at
    
    def self.find_by_domain(domain)
      results = Client.get self.endpoint
      result = results.find {|d| d['domain'] == domain }
      self.new(result) if result
    end
    
    def self.import(attrs)
      result = Client.post "import", attrs
      Job.new(id: result["job_id"]) if result
    end
    
    def files(dir = '.')
      result = Client.get File.join("sites", identifier, "files", dir)
      result.map { |r| File.new(r) } if result.is_a? Array
    end
    
    def pages
      result = Client.get "sites/#{identifier}/pages"
      result.map { |r| Page.new(r) } if result.is_a? Array
    end    
    
    def collections
      result = Client.get "sites/#{identifier}/collections"
      result.map { |r| Collection.new(r) } if result.is_a? Array
    end
    
    def posts
      Collection.new(path: 'posts', site_id: id).documents
    end
    
    def uploads
      Collection.new(path: 'uploads', site_id: id).files
    end
    
    def publish
      result = Client.post "sites/#{identifier}/publish", {}
      Job.new(id: result["job_id"]) if result
    end
    
    def full_url
      "http://#{domain}"
    end
    
    def filename
      "_config.yml"
    end
    
    def sha
      Siteleaf::GitHash.string(to_file)
    end
    
    def config
      attrs = {}
      attrs['title'] = title
      attrs['url'] = full_url
      attrs['timezone'] = timezone
      attrs['collections'] = collections_config
      attrs['defaults'] = defaults_config unless defaults.empty?
      attrs.merge(metadata.to_hash)
    end
    
    def to_file
      config.to_yaml
    end
  
    protected
    
    def uploads_collection
      Collection.new('title' => 'Uploads', 'path' => 'uploads', 'output' => true)
    end
    
    def defaults_config
      defaults.map do |d|
        { 'scope' => {}, 'values' => d['values'] }.tap do |default|
          default['scope']['path'] = d['path'] if d['path']
          default['scope']['type'] = d['type'] if d['type']
        end
      end
    end
    
    def collections_config
      collections.unshift(uploads_collection).each_with_object({}) do |collection, hash|
        hash[collection.path] = collection.metadata || {}
        hash[collection.path]['title'] = collection.title
        hash[collection.path]['output'] = collection.output
        hash[collection.path]['permalink'] = collection.permalink unless collection.permalink.nil?
      end
    end
    
  end
end