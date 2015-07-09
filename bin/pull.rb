def read_asset_server(asset_path)
  open(asset_path, /^1\.8/.match(RUBY_VERSION) ? 'r' : 'r:UTF-8') { |f| f.read }
end

def write_asset_local(asset_filename, file)
  FileUtils.mkdir_p(File.dirname(asset_filename))
  File.open(asset_filename, /^1\.8/.match(RUBY_VERSION) ? 'w' : 'w:UTF-8') { |f| f.write(file) }
end

def asset_exists_and_checksum(asset)
  # checksum is to tell us if the site has already been updated or not.
  File.exist?(asset.filename) && (asset.checksum == Digest::MD5.hexdigest(File.read(asset.filename)))
end

def get_theme_assets(site_id)
  return if (assets = Siteleaf::Theme.assets_by_site_id(site_id)).nil?
  updated_count = 0
  assets.each do |asset|
    next if asset_exists_and_checksum(asset)
    print "Downloading #{asset.filename}..."
    write_asset_local(asset.filename, read_asset_server(asset.file['url']))
    updated_count += 1
    print "complete.\n"
  end
  puts "=> #{updated_count} asset(s) downloaded.\n"
end
