module Plugins

  # Own
  require 'bujo/configuration/configuration'
  require 'bujo/configuration/structure'

  class PluginRepository
    def initialize(configuration)
      @configuration = configuration
    end

    def find_all
      local_plugins = find_local_plugins
      global_plugins = find_global_plugins(local_plugins)

      mandatory_plugins = find_mandatory_plugins
      if local_plugins.any? { |plugin| mandatory_plugins.include?(plugin) }
        raise StandardError "Mandatory plugins shouldn't be overridden"
      end

      [global_plugins, local_plugins].flatten
    end

    private

    def find_local_plugins
      @configuration.plugins
          .select { |plugin_name| File.exists?("#{to_local_plugin_file(plugin_name)}.rb") }
          .each { |plugin_name| require_relative to_local_plugin_file(plugin_name) }
          .map { |plugin_name| to_plugin_instance(plugin_name) }
    end

    def to_local_plugin_file(plugin_name)
      Configuration::Structure.local_plugin_path(to_plugin_file_name(plugin_name))
    end

    def find_global_plugins(local_plugins)
      @configuration.plugins
          .each { |plugin_name| require_relative to_global_plugin_file(plugin_name) }
          .map { |plugin_name| to_plugin_instance(plugin_name) }
          .select { |plugin| not local_plugins.include?(plugin) }
    end

    def to_global_plugin_file(plugin_name)
      Configuration::Structure.global_plugin_path(to_plugin_file_name(plugin_name))
    end

    def find_mandatory_plugins
      @configuration.mandatory_plugins
          .map { |plugin_name| to_plugin_instance(plugin_name) }
    end

    def to_plugin_file_name(plugin_name)
      "#{plugin_name}_plugin"
    end

    def to_plugin_instance(plugin_name)
      Object.const_get("Plugins::#{plugin_name.capitalize}Plugin").new
    end
  end
end