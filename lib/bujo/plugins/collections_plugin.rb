module Plugins
  # Ruby
  require 'fileutils'

  # Own
  require_relative 'plugin'
  require_relative '../options/option'

  include Options

  class CollectionsPlugin < Plugin
    def initialize
      super("collections", [
          Option.builder
              .with_name("c", "collection")
              .with_description("Create an entry for a collection in the journal")
              .valued
              .with_action(lambda { |collection| CollectionsPlugin.create_collection(collection) })
              .build,
      ])
    end

    def self.create_collection(collection)
      puts "Creating an entry for collection #{collection} in the journal"
      FileUtils.copy("templates/collection.adoc.tpl", "src/collections/#{collection}.adoc")
    end
  end
end