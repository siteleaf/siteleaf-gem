def help_commands
  %(  Commands:
    auth                Login in with your credentials
    s, server           Starts a local server
    c, config DOMAIN    Configure an existing directory
    n, new DOMAIN       Creates new site on siteleaf.net
    pull theme          Pulls theme files for configured site from Siteleaf
    push theme          Pushes all files in dir as theme to configured site
    publish             Publish website to hosting provider
    help                Prints this help document
    version             Prints the siteleaf gem version)
end

def help_options
  %(
  Options:
    -h, --help          Prints this help document
    -v, --version       Prints the siteleaf gem version
    -p, --port PORT     Binds local server to PORT (default: 9292)
    -q, --quiet         Suppress publish status
  See https://github.com/siteleaf/siteleaf-gem for additional documentation.
  )
end

def help
  "  Usage: siteleaf [COMMAND] [OPTIONS])\n" + help_commands + help_options
end
