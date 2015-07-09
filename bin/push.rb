def theme(site_id)
  Siteleaf::Theme.find_by_site_id(site_id)
end

def create_asset(updated_count, path, site_id)
  if Siteleaf::Asset.create(site_id: site_id, theme_id: theme(site_id).id, file: File.new(path), filename: path)
    print "complete.\n"
  else
    print "error.\n"
    return -1
  end
  updated_count
end

def file_valid?(path, ignore_paths)
  !File.directory?(path) && !ignore_paths.any? { |ignore| File.fnmatch?(ignore, path, File::FNM_CASEFOLD) || File.fnmatch?(ignore, File.basename(path), File::FNM_CASEFOLD) }
end

def assets_find(path, assets)
  assets.find { |asset| asset.filename == path }
end

def asset_valid?(asset, path)
  asset.nil? || (asset && asset.checksum != Digest::MD5.hexdigest(File.read(path)))
end

def upload_assets(updated_count, assets, ignore_paths, site_id)
  Dir.glob('**/*').each do |path|
    next unless file_valid?(path, ignore_paths)
    asset = assets_find(path, assets)
    next unless asset_valid?(asset, path)
    print "Uploading #{path}..."
    asset.delete if asset
    break if create_asset(updated_count, path, site_id) == -1
    updated_count += 1
  end
  updated_count
end

def get_missing_assets(assets)
  missing_assets = []
  assets.each { |asset| missing_assets << asset unless Dir.glob('**/*').include?(asset.filename) }
  missing_assets
end

def delete_missing_assets(missing_assets)
  missing_assets.each do |asset|
    print "Deleting #{asset.filename}..."
    asset.delete
    print "complete.\n"
  end
  puts "=> #{missing_assets.size} asset(s) deleted.\n"
end

def cleanup_old_assets(updated_count, assets)
  missing_assets = get_missing_assets(assets)
  if missing_assets.empty?
    puts "=> #{updated_count} asset(s) uploaded.\n"
  else
    print "=> #{updated_count} asset(s) uploaded. Delete the following #{missing_assets.size} unmatched asset(s)?\n"
    missing_assets.each { |asset| puts asset.filename }
    print '(y/n)? '
    delete_missing_assets(missing_assets) if stdin.gets.chomp == 'y'
  end
end

def put_theme_assets(site_id)
  assets = theme(site_id).assets
  ignore_paths = ['config.ru', '.*']
  ignore_paths += File.read('.siteleafignore').split(/\r?\n/) if File.exist?('.siteleafignore')
  updated_count = upload_assets(0, assets, ignore_paths, site_id)
  cleanup_old_assets(updated_count, assets)
end
