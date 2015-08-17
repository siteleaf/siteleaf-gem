Siteleaf Gem V2
===============

- [Installation](#installation)
- [Using the CLI](#using-the-cli)
- [Using this gem in your application](#using-this-gem-in-your-application)
- [Using the API](#using-the-api)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)

Installation
------------

The Siteleaf gem is available for installation on [Rubygems](https://rubygems.org/gems/siteleaf). To install run:

    gem install siteleaf --pre
    
Important: make sure to use `--pre` for V2. If maintaining sites with multiple versions, we recommend using a Gemfile.


Using the CLI
-------------

Important: if using a Gemfile, make sure to prepend all commands with `bundle exec` (e.g. `bundle exec siteleaf auth`).

**Authorize your account:**

    siteleaf auth
    
This will create an authorization file located at `~/.siteleaf.yml`. 

Alternatively, you can also use environment variables: `API_KEY=xxx API_SECRET=yyy siteleaf command`

You can also include use a `.siteleaf.yml` file in the root of your project:

```yaml
---
api_key: xxx
api_secret: yyy
site_id: zzz
```

**Set up a new site locally:**

    siteleaf new yoursite.com

This will create a new theme folder called `yoursite.com` in the directory where you ran this command. It will also create the site for you in your Siteleaf account. If you prefer not to create a new directory, run `siteleaf new yoursite.com .` instead.

**Configure an existing site:**

    siteleaf config yoursite.com

**Upload your files:**

To upload your theme to Siteleaf, run the following command:

    siteleaf push
    
**Download your files:**

To download your theme (or the default theme for new sites) from Siteleaf, run the following command:

    siteleaf pull
    
**Publish your site:**

To publish your site changes to your hosting provider, run the following command:

    siteleaf publish
    
**For a full list of commands, run:**

    siteleaf help


Using this gem in your application
----------------------------------
    
To use this gem in your application, add the following to your Gemfile:

    gem 'siteleaf', :git => 'git://github.com/siteleaf/siteleaf-gem.git', :branch => '2.0.0.pre'


Using the API
-------------

This gem also allows you to interact with the [Siteleaf API](https://github.com/siteleaf/siteleaf-api).

```ruby
require 'siteleaf'

# authentication
Siteleaf.api_key    = 'KEY'
Siteleaf.api_secret = 'SECRET'

# get authenticated user
me = Siteleaf::User.find('me')

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

# publish site
site.publish

# delete site
site.delete

# delete site by id
Siteleaf::Site.delete('5196f137cc8591956b000001')

# get all pages in site
pages = site.pages

# create new page in site
page = Siteleaf::Page.create({
  :site_id  => site.id,
  :title    => 'My Page',
  :body     => 'This is my first page.'
})

# get page by id
page = Siteleaf::Page.find('519719ddcc85910626000001')

# create new post in page
post = Siteleaf::Post.create({
  :title     => 'My Post',
  :body      => 'This is my first post.'
})

# update page, add metadata
post.title = 'New Title'
post.meta = {'foo' => 'bar'}
post.save

# upload file
asset = Siteleaf::File.create({
  :file     => File.open("~/image.png"), 
  :path     => "image.png"
})

# delete post
post.delete

# delete page by id
Siteleaf::Page.delete('519719ddcc85910626000001')
```

Troubleshooting
------------

**I can't install the Gem**

Try running:

    sudo gem install siteleaf


Contributing
------------

Help us improve this gem:

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
