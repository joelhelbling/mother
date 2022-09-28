require "bundler/setup"
require "fakefs/spec_helpers"
require "rspec/given"
require "pry"
require "mother"
require_relative "./yaml_file_helper"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include FakeFS::SpecHelpers
  config.include YamlFileHelper, :use_fakefs
end
