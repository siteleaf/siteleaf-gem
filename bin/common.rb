def fetch_site_id_config
  return nil unless File.exist?('config.ru')
  match = /:site_id => '([a-z0-9]{24})'/i.match(File.read('config.ru'))
  return match[1] unless match.nil?
  nil
end

def authenticated?
  if auth == false
    puts 'You are not authenticated. Please run `siteleaf auth`'
    return false
  end
  true
end

def site_configured?
  if (site_id = fetch_site_id_config).nil?
    puts "Site not configured, run `siteleaf config yoursite.com`.\n"
    return false
  end
  site_id
end

def configure_site(site)
  dir = ARGV.size >= 3 ? ARGV[2] : ARGV[1]
  Dir.mkdir(dir) unless File.directory?(dir)
  Dir.chdir(dir)
  config site
end
