require_relative 'bujo/plugins/plugin_register'
require_relative 'bujo/plugins/init_plugin'

include Plugins

def parse_plugins(args = [])
  PluginRegister.new
      .register(InitPlugin.new)
      .parse(args)
end