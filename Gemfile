source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0.2", ">= 8.0.2.1"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

gem 'sass-rails', '~> 6'
gem 'turbo-rails'
gem 'jbuilder'

gem 'prawn', '~> 2.5'
gem 'prawn-svg', '~> 0.36'

gem 'jsonapi-serializer', '~> 2.2'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

group :development, :test do
  gem 'rspec-rails'
  gem 'pdf-reader'
  gem 'rswag'
end
