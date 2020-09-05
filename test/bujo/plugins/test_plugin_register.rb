module Plugins
  # Ruby
  require 'minitest/autorun'

  # Own
  require_relative '../../../lib/bujo/plugins/plugin_register'
  require_relative '../../../lib/bujo/plugins/init_plugin'

  class PluginRegisterTest < Minitest::Test
    def test_init
      source_directory = Dir.pwd
      test_directory = Dir.mktmpdir("bujo")

      Dir.chdir(test_directory) do
        PluginRegister.new
            .register(InitPlugin.new)
            .parse %w[--init]

        assert_path_exists("bujo.yaml", "The configuration file, bujo.yaml, hasn't been created.")
        expected_configuration_file = File.read(File.join(source_directory, "assets/bujo/bujo.yaml"))
        actual_configuration_file = File.read("bujo.yaml")
        assert_equal(expected_configuration_file, actual_configuration_file, "The created configuration file doesn't match the template.")
      end
    end
  end
end