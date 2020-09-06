module Plugins
  # Ruby
  require 'fileutils'

  # Own
  require 'bujo/configuration/configuration'
  require 'bujo/configuration/structure'
  require 'bujo/plugins/plugin'
  require 'bujo/plugins/plugin_repository'
  require 'bujo/options/option'

  class InitPlugin < Plugin
    def initialize
      super("init", [
          Options::Option.builder
              .with_name("i", "init")
              .with_description("Init the structure of the journal")
              .with_action(-> { init_journal })
              .build
      ])
    end

    private def init_journal
      puts "Initializing a new BuJo..."
      FileUtils.copy(Configuration::Structure.global_asset_path("bujo/bujo.yaml"), Configuration::Structure.local_path("bujo.yaml"))
      Dir.mkdir(Configuration::Structure.sources_path)
      FileUtils.copy(Configuration::Structure.global_asset_path("bujo/plugins/init/template.adoc"), Configuration::Structure.source_path("index.adoc"))

      configuration = Configuration::Configuration.load
      plugin_repository = PluginRepository.new(configuration)
      plugin_repository.find_all
          .map { |plugin| plugin.directory }
          .select { |directory| not directory.nil? }
          .uniq
          .each { |directory| Configuration::Structure.create_source_directory(directory)}
    end
  end
end