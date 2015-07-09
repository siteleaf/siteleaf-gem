def auth(re_auth = false)
  Siteleaf.load_settings if !re_auth

  if re_auth or !Siteleaf.api_key
    print 'Enter your Siteleaf e-mail: '
    email = $stdin.gets.chomp

    print 'Enter your Siteleaf password: '
    system 'stty -echo'
    password = $stdin.gets.chomp
    system 'stty echo'

    puts "\nAuthorizing..."

    if (auth = Siteleaf::Client.auth(email, password)) && (auth.is_a?(Hash)) && (auth.has_key?('api_key'))
      File.open(Siteleaf.settings_file,'w') do|file|
        Marshal.dump({:api_key => auth['api_key'], :api_secret => auth['api_secret']}, file)
      end
      puts "=> Gem authorized." if re_auth
      return true
    else
      puts auth['error'] || "Could not authorize, check your e-mail or password."
      return false
    end
  end
end