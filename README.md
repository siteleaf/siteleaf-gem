Siteleaf Gem
============

[![Build Status](https://travis-ci.org/NYULibraries/siteleaf-gem.svg)](https://travis-ci.org/NYULibraries/siteleaf-gem)
[![Dependency Status](https://gemnasium.com/NYULibraries/siteleaf-gem.svg)](https://gemnasium.com/NYULibraries/siteleaf-gem)
[![Code Climate](https://codeclimate.com/github/NYULibraries/siteleaf-gem/badges/gpa.svg)](https://codeclimate.com/github/NYULibraries/siteleaf-gem)
[![Test Coverage](https://codeclimate.com/github/NYULibraries/siteleaf-gem/badges/coverage.svg)](https://codeclimate.com/github/NYULibraries/siteleaf-gem/coverage)
[![Issues](http://img.shields.io/github/issues/NYULibraries/lsiteleaf-gem.svg?style=flat-square)](http://github.com/NYULibraries/siteleaf-gem/issues)

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

The Siteleaf gem allows you to test and develop your sites locally. If using [Pow](http://pow.cx) or [Anvil](http://anvilformac.com), your local website will be automatically set up and can be accessed at `http://yoursite.dev`.

**(Optional, Mac-only) Install Pow for extra goodness:**

    curl get.pow.cx | sh

**Set up a new site locally:**

    siteleaf new yoursite.com

This will create a new theme folder called `yoursite.com` in the directory where you ran this command. It will also create the site for you in your Siteleaf account. If you prefer not to create a new directory, run `siteleaf new yoursite.com .` instead.

**Configure an existing site:**

    siteleaf config yoursite.com

Your site should now be accessible at `http://yoursite.dev`.

*or*

**If you don't want to install Pow, local sites can also be manually run:**

    siteleaf server

In this case, your local site can be accessed at `http://localhost:9292`.

**Lastly...**

Your local folder should contain at least one template file (`default.html`), for sample themes and documentation see: https://github.com/siteleaf/siteleaf-themes

For new sites, you will also need to create at least one page or post on https://manage.siteleaf.com in order to preview.

**Download your theme:**

To download your theme (or the default theme for new sites) from Siteleaf, run the following command:

    siteleaf pull theme

**Upload your theme:**

To upload your theme to Siteleaf, run the following command:

    siteleaf push theme

**Publish your site:**

To publish your site changes to your hosting provider, run the following command:

    siteleaf publish

**Switch Siteleaf users or re-authenticate:**

    siteleaf auth

**For a full list of commands, run:**

    siteleaf help


Using this gem in your application
----------------------------------

To use this gem in your application, add the following to your Gemfile:

    gem 'siteleaf', :git => 'git://github.com/siteleaf/siteleaf-gem.git'


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
  :parent_id => page.id,
  :title     => 'My Post',
  :body      => 'This is my first post.'
})

# update page, add metadata, add taxonomy
post.title = 'New Title'
post.meta = [ {"key" => "foo", "value" => "bar"} ]
post.taxonomy = [ {"key" => "Tags", "values" => ["One","Two","Three"]} ]
post.save

# upload asset to post (use site_id, page_id, or theme_id to upload to Site, Page, or Theme instead)
asset = Siteleaf::Asset.create({
  :post_id  => post.id,
  :file     => File.open("~/image.png"),
  :filename => "image.png"
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
