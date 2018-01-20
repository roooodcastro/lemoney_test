# frozen_string_literal: true

source 'https://rubygems.org'

gem 'rails', '~> 5.1.4'

gem 'bootstrap', '~> 4.0.0'
gem 'devise'
gem 'faker'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'rails-assets-momentjs', source: 'https://rails-assets.org'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails'
  gem 'pry'
  gem 'rubocop'
  gem 'sandi_meter', require: false,
      git: 'https://github.com/roooodcastro/sandi_meter',
      branch: 'one-line-method-fix'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', require: false
  # gem 'capybara-selenium', require: false
  gem 'database_cleaner'
  gem 'poltergeist'
  gem 'rails-controller-testing'
  gem 'rspec-collection_matchers'
  gem 'rspec-html-matchers'
  gem 'rspec-rails', '~> 3.5'
  # gem 'rspec-retry'
  # gem 'rspec-sidekiq'
  gem 'shoulda-matchers', require: false
  gem 'simplecov', require: false
  # gem 'webmock'
end
