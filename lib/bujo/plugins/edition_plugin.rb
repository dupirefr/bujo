module Plugins
  # Ruby
  require 'fileutils'

  # Own
  require 'bujo/plugins/plugin'
  require 'bujo/options/option'
  require 'bujo/configuration/configuration'

  class EditionPlugin < Plugin
    def initialize
      super("edition", [
          Options::Option.builder
              .with_name("e", "edit")
              .with_description("Init the structure of the journal")
              .valued
              .with_action(lambda { |file| edit(file) })
              .build
      ])
    end

    private def edit(relative_path)
      puts "Editing entry..."
      configuration = Configuration::Configuration.load
      system("#{configuration.editor} #{relative_path}")

      puts "Converting to HTML..."
      Utils::Converter.convert_file(relative_path)
    end
  end
end