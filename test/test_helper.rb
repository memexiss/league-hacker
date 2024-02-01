ENV["RAILS_ENV"] ||= "test"
unless ENV["COVERAGE"] == "false"
  require "simplecov"
  SimpleCov.formatters = [
    SimpleCov::Formatter::HTMLFormatter
  ]
  SimpleCov.start "rails" do
    add_group "Services", "app/services"

    add_filter "app/models/application_record.rb"
    add_filter "app/channels/application_cable/channel.rb"
    add_filter "app/channels/application_cable/connection.rb"

    skip_token "skip_test_coverage"
  end

  SimpleCov.at_exit do
    SimpleCov.result.format!
  end
end

require_relative "../config/environment"

require "rails/test_help"
require "minitest/focus"
require "minitest/rails"
require "minitest/spec"
require "minitest/unit"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)
  parallelize_setup do |worker|
    SimpleCov.command_name("#{SimpleCov.command_name}-#{worker}") unless ENV["COVERAGE"] == "false"
  end
  unless ENV["COVERAGE"] == "false"
    parallelize_teardown do |worker|
      # https://github.com/simplecov-ruby/simplecov/issues/718#issuecomment-538201587
      SimpleCov.result
    end
  end
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  include FactoryBot::Syntax::Methods
  include Devise::Test::IntegrationHelpers
end
