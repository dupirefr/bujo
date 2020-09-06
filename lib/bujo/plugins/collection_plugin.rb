module Plugins
  # Ruby
  require 'fileutils'

  # Own
  require 'bujo/plugins/plugin'
  require 'bujo/options/option'
  require 'bujo/templates/template_renderer'
  require 'bujo/utils/names'

  class CollectionPlugin < Plugin
    def initialize
      super("collections", [
          Options::Option.builder
              .with_name("c", "collection")
              .with_description("Create an entry for a collection in the journal")
              .valued
              .with_action(lambda { |collection| create_collection(collection) })
              .build,
      ])
    end

    def directory
      "collections"
    end

    def create_collection(collection_name)
      puts "Creating an entry for collection #{collection_name} in the journal"
      rendered_template = Templates::TemplateRenderer.new.render("collection/template.adoc", {
          :collection_name => collection_name
      })
      begin
        collection_source_path = Configuration::Structure.source_path("collections/#{Utils::NameUtils.computerize(collection_name)}.adoc")
        file = File.open(collection_source_path, "w") { |file| file.puts(rendered_template) }
      ensure
        file.close unless file.nil?
      end
    end
  end
end