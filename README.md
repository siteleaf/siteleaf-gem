<img alt="Siteleaf" src="https://learn.siteleaf.com/assets/images/logo.svg" width="10%">

Siteleaf v2 Gem & CLI
=====================

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Using the CLI](#using-the-cli)
- [Using this gem in your application](#using-this-gem-in-your-application)
- [Using the API](#using-the-api)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)


Prerequisites
-------------

Install Ruby and RubyGems: https://jekyllrb.com/docs/installation/


Installation
------------

The [Siteleaf](https://www.siteleaf.com) gem is available for installation on [RubyGems](https://rubygems.org/gems/siteleaf). To install run:

    gem install siteleaf
    
**Note:** the v2 gem only works with v2 sites. For documentation on v1 see: https://github.com/siteleaf/siteleaf-gem/tree/v1

If maintaining sites with multiple versions, we recommend using a [Gemfile](#using-this-gem-in-your-application).


Using the CLI
-------------

Important: if using a Gemfile, make sure to prepend all commands with `bundle exec` (e.g. `bundle exec siteleaf auth`).

**Authorize your account:**

    siteleaf auth
    
This will create an authorization file located at `~/.siteleaf.yml`. 

Alternatively, you can also use environment variables: `SITELEAF_API_KEY=xxx SITELEAF_API_SECRET=yyy siteleaf command`

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

    gem 'siteleaf', '~>2'


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

# get all pages in site
pages = site.pages

# create new page in site
page = Siteleaf::Page.create({
  :title    => 'My Page',
  :body     => 'This is my first page.',
  :site_id  => site.id
})

# get page by id
page = Siteleaf::Page.find('519719ddcc85910626000001')

# delete page by id
Siteleaf::Page.delete('519719ddcc85910626000001')

# get posts
posts = site.posts # or Collection.new(path: 'posts', site_id: site.id).documents

# create new post
post = Siteleaf::Documents.create({
  :title            => 'My Post',
  :body             => 'This is my first post.',
  :collection_path  => 'posts',
  :site_id          => site.id
})

# update post, add metadata
post.title = 'New Title'
post.metadata = {'foo' => 'bar'}
post.save

# delete post
post.delete

# get files in "uploads" collection
files = site.uploads # or Collection.new(path: 'uploads', site_id: site.id).files

# upload image into "uploads" collection
file = Siteleaf::File.create({
  :file             => File.new('~/image.png'), 
  :path             => 'image.png'
  :collection_path  => 'uploads',
  :site_id          => site.id
})

# get source files
files = site.source_files

# upload source file
file = Siteleaf::SourceFile.create({
  :file     => File.new('~/foo.html'), 
  :name     => '_includes/foo.html',
  :site_id  => site.id
})

# delete file
file.delete

# delete file by name
Siteleaf::SourceFile.new(name: '_includes/foo.html', site_id: site.id).delete

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
