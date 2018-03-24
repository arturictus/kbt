require "bundler/setup"
require "kbt"
module Kbt
  def self.templates_folder
    Pathname.new(File.expand_path('./templates', __FILE__))
  end
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
