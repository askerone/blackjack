require 'bundler/setup'

require 'factory_bot'
require 'pry'
require 'blackjack'

require 'simplecov'
require 'codecov'

SimpleCov.start

SimpleCov.formatter = SimpleCov::Formatter::Codecov if ENV['CI'] == 'true'

root = Pathname.new(Dir.pwd)

Dir[root.join('spec/factories/**/*.rb')].each { |file| require file }
Dir[root.join('spec/support/**/*.rb')].each { |file| require file }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each) do
    config_klass = Blackjack::Support::Config

    config_klass.setting_attr_accessors.each do |setting_accessor|
      next unless config_klass.instance.instance_variable_defined?(:"@#{setting_accessor}")
      config_klass.instance.remove_instance_variable(:"@#{setting_accessor}")
    end
  end
end
