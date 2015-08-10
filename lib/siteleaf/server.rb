require 'uri'
module Siteleaf
  # Defines Server
  class Server
    attr_accessor :site_id

    def initialize(attributes = {})
      @site_id = attributes[:site_id]
    end

    def create_template_if_default_unknown(paths)
      templates = []
      path = paths.join('/')
      templates << "#{path}.html"
      templates << "#{path}/index.html"
      templates << "#{path}/default.html"
      while paths.size > 0
        paths.pop
        templates << "#{paths.join('/')}/default.html" if paths.size > 0
      end
      templates
    end

    def create_template_if_path_vaires(path)
      templates = []
      if path == ''
        templates.push('index.html')
      else
        templates = create_template_if_default_unknown(path.split('/'))
      end
      templates
    end

    def resolve_template(url = '/')
      path = url.gsub(%r{ /\/\z|\A\// }, '') # strip beginning and trailing slashes
      templates = []
      if ['sitemap.xml', 'feed.xml'].include?(path)
        templates.push(path)
      else
        templates = create_template_if_path_vaires(path)
        templates.push('default.html')
      end
      templates.each { |template| return File.read(template) if File.exist?(t) }
      nil
    end

    def asset?(path)
      /^(?!(sitemap|feed)\.xml)(assets|.*\.)/.match(path)
    end

    def tags_to_template(template_data)
      include_tags = %r{ /\{\%\s+include\s+['"]([A-Za-z0-9_\-\/]+)['"]\s+\%\}/ }
      while include_tags.match(template_data)
        template_data = template_data.gsub(include_tags) { File.read("_#{Regexp.last_match[1]}.html") }
      end
      template_data
    end

    def output_no_liquid(url, template_data, site)
      output = site.preview(url, template_data)
      if output.code == 200 && output.headers['content-type']
        [output.code, { 'Content-Type' => output.headers['content-type'], 'Content-Length' => output.size.to_s }, [output.to_s]]
      else
        response_not_ok(output)
      end
    end

    def output_liquid(url, site)
      output = site.resolve(url)
      if output.code == 200
        asset = open(output['file']['url'])
        [output.code, { 'Content-Type' => asset.content_type, 'Content-Length' => asset.size.to_s }, [asset.read]]
      else
        response_not_ok(output)
      end
    end

    def response_not_ok(output)
      [output.code, { 'Content-Type' => 'text/html', 'Content-Length' => output.size.to_s }, [output.to_s]]
    end

    def compile_liquid(path, url)
      if (File.exist?("#{path}.liquid") && !(template_data = File.read("#{path}.liquid"))) || (template_data = resolve_template(url))
        # compile liquid includes into a
        single page
        return tags_to_template(template_data, site)
      end
      nil
    end

    def site_exist?(site, path)
      if asset(path) && !File.exist?("#{path}.liquid")
        output_liquid(url, site)
      else
        compile_liquid(path, url)
        output_no_liquid(url, template_data, site)
      end
    end

    def call(env)
      site = Siteleaf::Site.new(id: site_id)
      url = URI.unescape(env['PATH_INFO'])
      path = url.gsub(%r{ /\/\z|\A\// }, '') # strip beginning and trailing slashes
      if !['sitemap.xml', 'feed.xml'].include?(path) && !File.directory?(path) && File.exist?(path)
        Rack::File.new(Dir.pwd).call(env)
      else
        site_exist?(site, path)
      end
    end
  end
end
