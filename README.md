# About
This is the code for my [website](https://adrianjunge.de).
I used **Ruby on Rails**, not because I love pain, but more to learn something new.
This website is mainly about myself and some ctf stuff.
Have fun exploring :smile:

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

# Stop using precompiled assets
`bundle exec rake assets:clean` and delete all in `public/assets/*` especially `.manifest.json`

# Precompile assets
`rails assets:clobber`

`rails assets:precompile`

# Rebuilding project
`bundle exec rake db:migrate`
