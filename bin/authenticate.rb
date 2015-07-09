def authenticate
  print 'Enter your Siteleaf e-mail: '
  email = $stdin.gets.chomp
  print "Enter your Siteleaf password: \n"
  system 'stty -echo'
  password = $stdin.gets.chomp
  system 'stty echo'
  Siteleaf::Client.auth(email, password)
end

def authenticate_write_file(authenticate)
  File.open(Siteleaf.settings_file, 'w') do |file|
    Marshal.dump({ api_key: authenticate['api_key'], api_secret: authenticate['api_secret'] }, file)
  end
  puts '=> Gem authorized.'
  true
end

def auth_error(authenticate = nil)
  puts authenticate.nil? ? 'Could not authorize, check your e-mail or password.' : authenticate['error']
  false
end

def authenticate_true(re_auth)
  Siteleaf.load_settings unless re_auth
  return true if !re_auth && Siteleaf.api_key
end

def auth(re_auth = false)
  return if authenticate_true re_auth
  authentication =  authenticate
  return auth_error(authentication) unless authentication.is_a?(Hash) && authentication.key?('api_key')
  authenticate_write_file(authentication)
end
