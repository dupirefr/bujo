module Plugins
  # Ruby
  require 'fileutils'

  # Own
  require 'bujo/plugins/plugin'
  require 'bujo/options/option'
  require 'bujo/utils/names'
  require 'bujo/utils/files'

  class CollectionPlugin < Plugin
    def initialize(dependencies = [])
      super("collections", [
          Options::Option.builder
              .with_name("c", "collection")
              .with_description("Create an entry for a collection in the journal")
              .valued
              .with_action(lambda { |collection| create_collection(collection) })
              .build,
      ])

      @template_renderer = dependencies[:template_renderer]
    end

    def directory
      "collections"
    end

    def create_collection(collection_name)
      puts "Creating an entry for collection #{collection_name} in the journal"
      rendered_template = @template_renderer.render("collection/template.adoc", {
          :collection_name => collection_name
      })
      collection_source_path = Configuration::Structure.source_path("collections/#{Utils::NameUtils.computerize(collection_name)}.adoc")
      Utils::Files.write(collection_source_path, rendered_template)
    end
  end
end