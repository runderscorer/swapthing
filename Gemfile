source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '6.1.1'
ruby '3.0.5'

# webrick isn't shipped with ruby 3
gem 'webrick', '~> 1.7'

gem 'pg', '~> 1.1'
gem 'devise', ">= 4.7.1"
gem 'devise_invitable'
gem 'simple_form'
gem 'dotenv-rails'

# Use SCSS for stylesheets
gem 'sass-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

gem 'font-awesome-sass'

gem 'draper'

gem 'pickadate-rails'

gem 'aws-sdk-s3', require: false

gem 'mailgun-ruby'

gem 'react_on_rails'
gem 'webpacker'

gem 'link_thumbnailer'

group :production, :staging do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'pry'
  gem 'launchy'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'rails-controller-testing'
  gem 'database_cleaner'
end

gem 'mini_racer', platforms: :ruby