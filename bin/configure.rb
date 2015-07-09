def config_ru_text(site)
  "# Intended for development purposes only, do not upload or use in production.
  # See https://github.com/siteleaf/siteleaf-gem for documentation.
  require 'rubygems'
  require 'siteleaf'
  run Siteleaf::Server.new(:site_id => '#{site.id}')"
end

def not_configured
  puts "=> Site configured, run `siteleaf server` to test site locally.\n"
  false
end

def config(site)
  File.open('config.ru', 'w') { |file| file.write config_ru_text(site) }
  pow_path = File.expand_path('~/.pow')
  return not_configured unless File.directory?(pow_path)
  site_no_tld = site.domain.gsub(/\.[a-z]{0,4}$/i, '')
  site_symlink = "#{pow_path}/#{site_no_tld}"
  FileUtils.rm(site_symlink) if File.symlink?(site_symlink)
  FileUtils.symlink(File.expand_path('.'), site_symlink)
  puts "=> Site configured with Pow, open `http://#{site_no_tld}.dev` to test site locally.\n"
end
