module Configuration
  # Ruby
  require 'psych'

  # Own
  require 'bujo/plugins/plugin'

  class Configuration
    attr_reader :mandatory_plugins, :extra_plugins

    private def initialize(plugins)
      @mandatory_plugins = %w[init build]
      @extra_plugins = plugins
    end

    def plugins
      [@mandatory_plugins, @extra_plugins].flatten
    end

    def self.load(configuration_file = "bujo.yaml")
      yaml = Psych.load_file(configuration_file)
      plugins = (yaml['plugins'] || [])
      Configuration.new(plugins)
    end
  end
end