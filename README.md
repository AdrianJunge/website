# About
This is the code for my [website](TODO: README hyperlink).
It is written in Ruby, not because I love pain, but more to learn new stuff.

# Installation
`apt install ruby-full`
`gem install rails`
`gem install bundler`

# Starting
`cd website && bundle install`
`rails server` or `bin/dev`

# Help
When you have installation problems try out
`gem update --system`
`bundle clean --force`
`bundle install`

# Stop using precompiled assets
`bundle exec rake assets:clean`
and delete all in `public/assets/*` especially `.manifest.json`

# Precompile assets
```
rails assets:clobber
rails assets:precompile
```

# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
