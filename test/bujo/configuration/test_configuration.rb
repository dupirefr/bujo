module Configuration
  # Ruby
  require 'minitest/autorun'

  # Own
  require 'bujo/configuration/configuration'
  require 'bujo/plugins/init_plugin'

  class ConfigurationTest < Minitest::Test
    def test_load_no_plugins
      configuration = Configuration.load("test/bujo/configuration/no_plugins_configuration.yaml")

      mandatory_plugins = %w[init build]
      extra_plugins = []
      plugins = %w[init build]
      assert_equal(mandatory_plugins, configuration.mandatory_plugins)
      assert_equal(extra_plugins, configuration.extra_plugins)
      assert_equal(plugins, configuration.plugins)
    end

    def test_load_some_plugins
      configuration = Configuration.load("test/bujo/configuration/some_plugins_configuration.yaml")

      mandatory_plugins = %w[init build]
      extra_plugins = %w[day month]
      plugins = %w[init build day month]
      assert_equal(mandatory_plugins, configuration.mandatory_plugins)
      assert_equal(extra_plugins, configuration.extra_plugins)
      assert_equal(plugins, configuration.plugins)
    end
  end
end