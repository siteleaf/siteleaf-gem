Siteleaf
==========

Installation
------------

Build gem from source:

    gem build siteleaf.gemspec

Then install with:

    gem install siteleaf


Testing sites locally
---------------------

The Siteleaf gem allows you to test and develop your sites locally.

Set up a new site locally:

    siteleaf new yoursite.com

Configure an existing site:

    siteleaf config yoursite.com

If using [Pow](http://pow.cx), your local website will be automatically set up and can be accessed at `http://yoursite.dev`.

Local sites can also be manually run:

    siteleaf server
  
In this case, your local site can be accessed at `http://localhost:9292`.

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


Contributing
------------

Help us improve this gem:

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
