module Plugins
  # Ruby
  require 'minitest/autorun'

  # Own
  require 'bujo/plugins/edit_plugin'
  require 'bujo/configuration/editor'

  require_relative '../test_utils'

  class EditPluginTest < Minitest::Test
    def test_edit_entry
      execute_in_test_directory(-> (_) {
        create_index_file

        editor_mock = Minitest::Mock.new
        editor_mock.expect(:nil?, false)
        editor_mock.expect(:call, _, ["src/index.adoc"])
        edit_plugin = EditPlugin.new([], editor_mock)

        edit_plugin.edit_entry("src/index.adoc")

        index_file_is_edited(editor_mock)
        index_file_is_created
      })
    end

    private

    def create_index_file
      FileUtils.mkdir("src")
      FileUtils.touch("src/index.adoc")
    end

    def index_file_is_edited(editor_mock)
      editor_mock.verify
    end

    def index_file_is_created
      file_is_created("target/index.html")
    end

    def file_is_created(file_path)
      assert_path_exists(file_path, "The file, #{file_path}, hasn't been created.")
    end
  end
end