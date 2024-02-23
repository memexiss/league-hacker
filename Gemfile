source "https://rubygems.org"

ruby "3.1.2"

gem "rails", "~> 7.1.3"
gem "jsbundling-rails"
gem "devise", "~> 4.9"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "jbuilder"
gem "redis", ">= 4.0.1"
gem 'esbuild-rails'
gem 'phony_rails', '~> 0.14.2'
gem "tzinfo-data", platforms: %i[ mswin mswin64 mingw x64_mingw jruby ]
gem "bootsnap", require: false

group :development do
  gem "web-console"
  gem "error_highlight", ">= 0.4.0", platforms: [:ruby]
end

group :test do
  gem "minitest-ci", require: false
  gem "minitest-focus"
  gem "minitest-rails"
  gem "minitest-stub_any_instance"
  gem "rails-controller-testing"
  gem "simplecov", require: false
  gem "simplecov-json", require: false
  gem "timecop"
  gem "vcr" # because more vcrs
  gem "webmock" # needed by vcr
end

group :development, :test do
  gem "factory_bot_rails", "~> 6.2.0"
  gem "ffaker"
  gem "pry-rails"
  gem "standard"
  gem "debug", platforms: %i[mri mingw x64_mingw]
end
