require 'fileutils'

require_relative 'module'
require_relative '../options/option'

class CollectionsModule < Module
  def initialize
    super("collections", [
        OptionBuilder.new
            .with_name("c", "collection")
            .with_description("Create an entry for a collection in the journal")
            .valued
            .with_action(lambda { |collection| CollectionsModule.create_collection(collection) })
            .build,
    ])
  end

  def self.create_collection(collection)
    puts "Creating an entry for collection #{collection} in the journal"
    FileUtils.copy("templates/collection.adoc.tpl", "src/collections/#{collection}.adoc")
  end
end