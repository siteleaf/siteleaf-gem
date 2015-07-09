def get_theme_assets(site_id)
  if assets = Siteleaf::Theme.assets_by_site_id(site_id)
    updated_count = 0
    assets.each do |asset|
      if File.exist?(asset.filename) && (asset.checksum == Digest::MD5.hexdigest(File.read(asset.filename)))
        # file is up to date
      else
        print "Downloading #{asset.filename}..."
        file = open(asset.file['url'], /^1\.8/.match(RUBY_VERSION) ? 'r' : 'r:UTF-8') { |f| f.read }
        FileUtils.mkdir_p(File.dirname(asset.filename))
        File.open(asset.filename, /^1\.8/.match(RUBY_VERSION) ? 'w' : 'w:UTF-8') { |f| f.write(file) }
        updated_count += 1
        print "complete.\n"
      end
    end
    puts "=> #{updated_count} asset(s) downloaded.\n"
  end
end