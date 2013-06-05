Siteleaf Gem
============

- [Installation](#installation)
- [Testing sites locally](#testing-sites-locally)
- [Using this gem in your application](#using-this-gem-in-your-application)
- [Using the API](#using-the-api)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)

Installation
------------

The Siteleaf gem is available for installation on [Rubygems](https://rubygems.org/gems/siteleaf). To install run:

    gem install siteleaf


Testing sites locally
---------------------

The Siteleaf gem allows you to test and develop your sites locally.

**Set up a new site locally:**

    siteleaf new yoursite.com

This will create a new theme folder in the directory where you ran this command. It will also create the site for you in your Siteleaf account.

**Configure an existing site:**

    siteleaf config yoursite.com

**(Optional) Install Pow for extra goodness:**

If using [Pow](http://pow.cx), your local website will be automatically set up and can be accessed at `http://yoursite.dev`.

If you don't have Pow (or Anvil) installed, run:

    curl get.pow.cx | sh

**Or if you don't want to install Pow, local sites can also be manually run:**

    siteleaf server
  
In this case, your local site can be accessed at `http://localhost:9292`.

**Lastly...**

Your local folder should contain at least one template file (`default.html`), for sample themes and documentation see: https://github.com/siteleaf/siteleaf-themes


Using this gem in your application
----------------------------------
    
To use this gem in your application, add the following to your Gemfile:

    gem 'siteleaf', :git => 'git://github.com/siteleaf/siteleaf-gem.git'


Using the API
-------------

This gem also allows you to interact with the Siteleaf API.

```ruby
require 'siteleaf'

# authentication
Siteleaf.api_key    = 'KEY'
Siteleaf.api_secret = 'SECRET'

# get authenticated user
me = Siteleaf::Users.find('me')

# get all sites
sites = Siteleaf::Site.all

# create new site
site = Siteleaf::Site.create({
  :title    => 'My Website',
  :domain   => 'mywebsite.com'
})

# get site by id
site = Siteleaf::Site.find('5196f137cc8591956b000001')

# update site
site.title = 'New Title'
site.save

# delete site
site.delete

# delete site by id
Siteleaf::Site.delete('5196f137cc8591956b000001')

# get all pages in site
pages = site.pages

# create new page in site
page = Siteleaf::Page.create({
  :title    => 'My Page',
  :slug     => 'my-page', # optional
  :body     => 'This is my first page.'
})

# get page by id
page = Siteleaf::Page.find('519719ddcc85910626000001')

# update page, add metadata
page.title = 'New Title'
page.meta = [{"key" => "foo", "value" => "bar"}]
page.save

# delete page
page.delete

# delete page by id
Siteleaf::Page.delete('519719ddcc85910626000001')
```

Troubleshooting
------------

**I can't install the Gem**

Try running:

    sudo gem install siteleaf

**I'm getting a message mentioning** `undefined method 'exists?'`

Check what version of Ruby you're running:

    ruby -v

If it's below 1.9, you'll need to update your version of ruby.


Contributing
------------

Help us improve this gem:

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
