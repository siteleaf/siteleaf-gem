def put_theme_assets(site_id)
  theme = Siteleaf::Theme.find_by_site_id(site_id)
  assets = theme.assets
  updated_count = 0
  ignore_paths = ['config.ru', '.*']
  ignore_paths += File.read('.siteleafignore').split(/\r?\n/) if File.exists?('.siteleafignore')

  # upload files
  paths = Dir.glob("**/*")
  paths.each do |path|
    if !File.directory?(path) && !ignore_paths.any?{|i| File.fnmatch?(i, path, File::FNM_CASEFOLD) || File.fnmatch?(i, File.basename(path), File::FNM_CASEFOLD) }
      asset = assets.find{|a| a.filename == path }
      if asset.nil? || (asset && asset.checksum != Digest::MD5.hexdigest(File.read(path)))
        print "Uploading #{path}..."
        asset.delete if asset
        if response = Siteleaf::Asset.create({:site_id => site_id, :theme_id => theme.id, :file => File.new(path), :filename => path})
          updated_count += 1
          print "complete.\n"
        else
          print "error.\n"
          break
        end
      end
    end
  end

  # check for old files
  missing_assets = []
  assets.each do |asset|
    missing_assets << asset if !paths.include?(asset.filename)
  end
  if missing_assets.empty?
    puts "=> #{updated_count} asset(s) uploaded.\n"
  else
    print "=> #{updated_count} asset(s) uploaded. Delete the following #{missing_assets.size} unmatched asset(s)?\n"
    missing_assets.each do |asset|
      puts asset.filename
    end
    print '(y/n)? '
    if $stdin.gets.chomp == 'y'
      missing_assets.each do |asset|
        print "Deleting #{asset.filename}..."
        asset.delete
        print "complete.\n"
      end
      puts "=> #{missing_assets.size} asset(s) deleted.\n"
    end
  end
end