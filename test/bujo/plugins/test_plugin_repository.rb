module Plugins
  # Ruby
  require 'minitest/autorun'
  require 'fileutils'

  # Own
  require 'bujo/configuration/configuration'
  require 'bujo/plugins/plugin_repository'
  require 'bujo/plugins/init_plugin'
  require 'bujo/plugins/build_plugin'
  require 'bujo/plugins/day_plugin'
  require 'bujo/plugins/month_plugin'

  require_relative '../test_utils'

  class PluginRepositoryTest < Minitest::Test
    def test_find_all_only_mandatory
      configuration = Configuration::Configuration.load("test/bujo/configuration/no_plugins_configuration.yaml")
      plugins = PluginRepository.new(configuration).find_all

      expected_plugins = [InitPlugin.new, BuildPlugin.new]

      assert_equal(expected_plugins, plugins)
    end

    def test_find_all_only_mandatory_redefined
      configuration = Configuration::Configuration.load("test/bujo/configuration/no_plugins_configuration.yaml")

      execute_in_test_directory(-> (working_directory) {
        Dir.mkdir("plugins")
        FileUtils.copy(
            File.join(working_directory, "lib/bujo/plugins/init_plugin.rb"),
            "plugins/init_plugin.rb"
        )

        assert_raises(StandardError, "Mandatory plugins shouldn't be overridden") do
          PluginRepository.new(configuration).find_all
        end
      })
    end

    def test_find_all_extra
      configuration = Configuration::Configuration.load("test/bujo/configuration/some_plugins_configuration.yaml")
      plugins = PluginRepository.new(configuration).find_all

      expected_plugins = [InitPlugin.new, BuildPlugin.new, DayPlugin.new, MonthPlugin.new]

      assert_equal(expected_plugins, plugins)
    end

    def test_find_all_extra_redefined
      configuration = Configuration::Configuration.load("test/bujo/configuration/some_plugins_configuration.yaml")

      execute_in_test_directory(-> (working_directory) {
        Dir.mkdir("plugins")
        FileUtils.copy(
            File.join(working_directory, "lib/bujo/plugins/day_plugin.rb"),
            "plugins/day_plugin.rb"
        )

        plugins = PluginRepository.new(configuration).find_all

        expected_plugins = [InitPlugin.new, BuildPlugin.new, MonthPlugin.new, DayPlugin.new]

        assert_equal(expected_plugins, plugins)
      })
    end
  end
end