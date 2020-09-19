module Plugins
  # Ruby
  require 'fileutils'

  # Own
  require 'bujo/plugins/plugin'
  require 'bujo/options/option'
  require 'bujo/configuration/configuration'
  require 'bujo/utils/converter'

  class EditPlugin < Plugin
    def initialize(dependencies = [], editor = nil)
      super("edition", [
          Options::Option.builder
              .with_name("e", "edit")
              .with_description("Init the structure of the journal")
              .valued
              .with_action(lambda { |file| edit_entry(file) })
              .build
      ])

      # TODO C'mon, you're better than that
      @editor = editor.nil? ? Configuration::Configuration.load.editor : editor
    end

    def edit_entry(relative_path)
      puts "Editing entry..."
      @editor.call(relative_path)

      puts "Converting to HTML..."
      Utils::Converter.convert_file(relative_path)
    end

  end
end