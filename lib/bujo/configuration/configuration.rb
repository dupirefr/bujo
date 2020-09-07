module Configuration
  # Ruby
  require 'psych'

  # Own
  require 'bujo/plugins/plugin'
  require 'bujo/configuration/editor'

  class Configuration
    attr_reader :mandatory_plugins, :extra_plugins, :editor

    private def initialize(plugins, editor)
      @mandatory_plugins = %w[init build]
      @extra_plugins = plugins
      @editor = editor
    end

    def plugins
      [@mandatory_plugins, @extra_plugins].flatten
    end

    def self.load(configuration_file = "bujo.yaml")
      yaml = Psych.load_file(configuration_file)
      plugins = (yaml['plugins'] || [])
      Configuration.new(plugins, Editor.new(yaml['editor']))
    end
  end
end