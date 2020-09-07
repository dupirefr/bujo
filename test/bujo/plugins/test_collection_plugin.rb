module Plugins
  # Ruby
  require 'minitest/autorun'
  require 'fileutils'

  # Own
  require 'bujo/plugins/collection_plugin'

  require_relative '../test_utils'

  class CollectionPluginTest < Minitest::Test
    def test_directory
      collection_plugin = CollectionPlugin.new

      assert_equal("collections", collection_plugin.directory)
    end

    def test_create_collection_single_word_standard_characters
      execute_in_test_directory(-> (working_directory) {
        create_collections_directory

        collection_plugin = CollectionPlugin.new
        collection_plugin.create_collection("Books")

        collection_file_is_created(working_directory, "books")
      })
    end

    def test_create_collection_single_word_accentuated_characters
      execute_in_test_directory(-> (working_directory) {
        create_collections_directory

        collection_plugin = CollectionPlugin.new
        collection_plugin.create_collection("Cafés")

        collection_file_is_created(working_directory, "cafes")
      })
    end

    def test_create_collection_multiple_words_special_characters
      execute_in_test_directory(-> (working_directory) {
        create_collections_directory

        collection_plugin = CollectionPlugin.new
        collection_plugin.create_collection("Café l'Amour")

        collection_file_is_created(working_directory, "cafe_l_amour")
      })
    end

    private

    def create_collections_directory
      FileUtils.mkdir_p("src/collections")
    end

    def collection_file_is_created(working_directory, collection_file_name)
      file_is_created(working_directory, "src/collections/#{collection_file_name}.adoc", "test/bujo/plugins/#{collection_file_name}.adoc")
    end

    def file_is_created(working_directory, file_path, assets_file_path)
      assert_path_exists(file_path, "The file, #{file_path}, hasn't been created.")
      expected_file = File.read(File.join(working_directory, assets_file_path))
      actual_file = File.read(file_path)
      assert_equal(expected_file, actual_file, "The created file doesn't match the template.")
    end
  end
end