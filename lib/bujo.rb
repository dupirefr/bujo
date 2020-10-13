require 'bujo/configuration/configuration'
require 'bujo/configuration/structure'
require 'bujo/plugins/plugin_repository'
require 'bujo/plugins/plugin_register'
require 'bujo/plugins/init_plugin'
require 'bujo/templates/template_renderer'

def parse(args = [])
  template_renderer = Templates::TemplateRenderer.new

  if File.exists?(Configuration::Structure.local_path("bujo.yaml"))
    configuration = Configuration::Configuration.load
    plugin_repository = Plugins::PluginRepository.new(configuration, template_renderer)
    Plugins::PluginRegister.new(plugin_repository.find_all).parse(args)
  else
    Plugins::PluginRegister
        .new([Plugins::InitPlugin.new({template_renderer: template_renderer})])
        .parse(args)
  end
end