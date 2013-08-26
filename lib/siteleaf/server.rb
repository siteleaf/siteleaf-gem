module Siteleaf
  class Server
  
    attr_accessor :site_id
    
    def initialize(attributes = {})
      self.site_id = attributes[:site_id]
    end
    
    def resolve_template(url = "/")
      path = url.gsub(/\/\z|\A\//, '') #strip beginning and trailing slashes
      paths = path.split("/")
      templates = []
    
      if ['sitemap.xml','feed.xml'].include?(path)
        templates.push(path)
      else
        if path == ""
          templates.push("index.html")
        else
          templates.push("#{paths.join('/')}.html")
          templates.push("#{paths.join('/')}/index.html")
          templates.push("#{paths.join('/')}/default.html")
          while paths.size > 0
            paths.pop
            templates.push("#{paths.join('/')}/default.html") if paths.size > 0
          end
        end
        templates.push("default.html")
      end
      
      templates.each do |t|
        return File.read(t) if File.exist?(t)
      end
      
      return nil
    end
     
    def call(env)
      require 'uri'
      
      site = Siteleaf::Site.new({:id => self.site_id})
      
      url = URI.unescape(env['PATH_INFO'])
      path = url.gsub(/\/\z|\A\//, '') #strip beginning and trailing slashes
      
      if !['sitemap.xml','feed.xml'].include?(path) and !File.directory?(path) and File.exist?(path)
        Rack::File.new(Dir.pwd).call(env)
      else
        template_data = nil
        is_asset = /^(?!(sitemap|feed)\.xml)(assets|.*\.)/.match(path)
        
        if is_asset and !File.exist?("#{path}.liquid")
          output = site.resolve(url)
          if output.code == 200
            require 'open-uri'
            asset = open(output['file']['url'])
            [output.code, {'Content-Type' => asset.content_type}, [asset.read]]
          else
            [output.code, {'Content-Type' => 'text/html'}, [output.to_s]]
          end
        else
          if (File.exist?("#{path}.liquid") and template_data = File.read("#{path}.liquid")) or (template_data = resolve_template(url))
            # compile liquid includes into a single page
            include_tags = /\{\%\s+include\s+['"]([A-Za-z0-9_\-\/]+)['"]\s+\%\}/
            while include_tags.match(template_data)
              template_data = template_data.gsub(include_tags) { |i| File.read("_#{$1}.html") }
            end
          end
        
          output = site.preview(url, template_data)
          if output.code == 200 && output.headers[:content_type]
            puts output.class
            [output.code, {'Content-Type' => output.headers[:content_type]}, [output.to_s]]
          else
            [output.code, {'Content-Type' => 'text/html'}, [output.to_s]]
          end
        end
      end
    end
  end
end