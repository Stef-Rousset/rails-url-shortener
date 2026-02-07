source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.4"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.2.0", ">= 7.2.3"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 6.3.1"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Use Tailwind CSS [https://github.com/rails/tailwindcss-rails]
gem "tailwindcss-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis"

#authentification [https://github.com/heartcombo/devise]
gem "devise"

# authorization [https://github.com/varvet/pundit]
gem "pundit"

# excel files [https://github.com/caxlsx/caxlsx]
gem 'caxlsx'
gem 'caxlsx_rails'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# deal with rss feeds [https://github.com/ruby/rss]
gem 'rss'

# deal with jobs [https://github.com/sidekiq/sidekiq]
gem 'sidekiq', "~> 6.5.12"
# see errors in jobs [https://github.com/mhfs/sidekiq-failures]
gem "sidekiq-failures", "~> 1.0"
# schedule jobs [https://github.com/sidekiq-scheduler/sidekiq-scheduler]
gem 'sidekiq-scheduler'

# deal with ChatGPT [https://github.com/alexrudall/ruby-openai]
gem "ruby-openai"
# Use Sass to process CSS
# gem "sassc-rails"

#import excel files [https://github.com/roo-rb/roo]
gem "roo", "~> 2.10.0"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

#added after github securtity alert [https://github.com/advisories/GHSA-592j-995h-p23j]
gem "rdoc", "6.5.1.1"

## gems updated after bundler-audit
# [https://github.com/ruby/rexml]
gem "rexml", '>= 3.3.9'

# [https://github.com/rails/rails-html-sanitizer]
gem 'rails-html-sanitizer', '>= 1.6.1'

# [https://github.com/rack/rack]
gem 'rack', '~> 2.2', '>= 2.2.8.1'

# [https://github.com/rails/thor]
gem 'thor', '1.4.0'

# [https://github.com/floraison/fugit]
gem 'fugit', '1.11.1'

group :development, :test do
  # Debug [https://github.com/deivid-rodriguez/byebug]
  gem "byebug", "~> 11.0", platform: :mri
  #tests with rspec [https://github.com/rspec/rspec-rails]
  gem 'rspec-rails', '~> 6.0.0'
  # data for tests [https://github.com/thoughtbot/factory_bot_rails]
  gem "factory_bot_rails"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Annotate models, routes and tests [https://github.com/ctran/annotate_models]
  gem 'annotate'

  # deal with n + 1 queries [https://github.com/flyerhzm/bullet]
  gem 'bullet', '~> 7.2'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
   gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  # use asseet_template [https://github.com/rails/rails-controller-testing]
  gem 'rails-controller-testing'
end
