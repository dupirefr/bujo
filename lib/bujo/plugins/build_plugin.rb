module Plugins
  # Ruby
  require 'fileutils'
  require 'asciidoctor'

  # Own
  require 'bujo/configuration/globals'
  require 'bujo/plugins/plugin'
  require 'bujo/options/option'
  require 'bujo/utils/converter'

  class BuildPlugin < Plugin
    def initialize(dependencies = [])
      super("build", [
          Options::Option.builder
              .with_name("b", "build")
              .with_description("Build HTML representation of the journal")
              .with_action(-> { build_journal })
              .build
      ])
    end

    def build_journal
      clean_target
      convert_files
    end

    private

    def clean_target
      puts "Cleaning target..."
      FileUtils.rm_rf(Configuration::Structure.targets_path)
    end

    def convert_files
      puts "Converting to HTML..."
      Dir.glob(File.join(Configuration::Structure.sources_path, "**/*"))
          .filter { |item| File.file?(item) }
          .each { |file| Utils::Converter.for(file).convert }
    end
  end
end