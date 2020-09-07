module Plugins
  # Ruby
  require 'minitest/autorun'

  # Own
  require 'bujo'

  require_relative 'test_utils'

  class BujoTest < Minitest::Test
    def test_init
      execute_in_test_directory(-> (working_directory) {
        parse %w[--init]

        assert_path_exists("bujo.yaml", "The configuration file, bujo.yaml, hasn't been created.")
        expected_configuration_file = File.read(File.join(working_directory, "assets/bujo/bujo.yaml"))
        actual_configuration_file = File.read("bujo.yaml")
        assert_equal(expected_configuration_file, actual_configuration_file, "The created configuration file doesn't match the template.")
      })
    end
  end
end