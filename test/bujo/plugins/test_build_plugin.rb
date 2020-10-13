module Plugins
  # Ruby
  require 'minitest/autorun'
  require 'fileutils'

  # Own
  require 'bujo/plugins/build_plugin'
  require 'bujo/utils/files'

  require_relative '../test_utils'

  class BuildPluginTest < Minitest::Test
    def test_build_journal_when_top_level_file_and_no_target
      execute_in_test_directory(-> (_) {
        create_index_file

        build_plugin = BuildPlugin.new
        build_plugin.build_journal

        index_file_is_created
      })
    end

    def test_build_journal_when_multi_level_files_and_no_target
      execute_in_test_directory(-> (_) {
        create_index_file
        create_log_file

        build_plugin = BuildPlugin.new
        build_plugin.build_journal

        index_file_is_created
        log_file_is_created
      })
    end

    def test_build_journal_when_multi_level_files_and_already_target
      execute_in_test_directory(-> (_) {
        create_index_file
        create_log_file
        create_target_with_garbage

        build_plugin = BuildPlugin.new
        build_plugin.build_journal

        index_file_is_created
        log_file_is_created
        garbage_has_been_removed
      })
    end

    def test_build_journal_when_non_adoc_file
      execute_in_test_directory(-> (_) {
        create_index_file
        create_non_adoc_file

        build_plugin = BuildPlugin.new
        build_plugin.build_journal

        index_file_is_created
        non_adoc_file_has_been_copied
      })
    end

    private

    def create_index_file
      FileUtils.mkdir("src")
      FileUtils.touch("src/index.adoc")
    end

    def create_log_file
      FileUtils.mkdir("src/logs")
      FileUtils.touch("src/logs/2020-09-01.adoc")
    end

    def create_non_adoc_file
      FileUtils.touch("src/notes.txt")
      Utils::Files.write("src/notes.txt", "Notes")
    end

    def create_target_with_garbage
      FileUtils.mkdir("target")
      FileUtils.touch("target/garbage.html")
    end

    def index_file_is_created
      file_is_created("target/index.html")
    end

    def log_file_is_created
      file_is_created("target/logs/2020-09-01.html")
    end

    def non_adoc_file_has_been_copied
      file_is_created("target/notes.txt")
      original_file_content = File.read("src/notes.txt")
      copied_file_content = File.read("target/notes.txt")
      assert_equal(original_file_content, copied_file_content)
    end

    def file_is_created(file_path)
      assert_path_exists(file_path, "The file, #{file_path}, hasn't been created.")
    end

    def garbage_has_been_removed
      file_has_been_removed("target/garbage.html")
    end

    def file_has_been_removed(file_path)
      assert_path_doesnt_exist(file_path, "The file, #{file_path}, hasn't been removed.")
    end

    def assert_path_doesnt_exist(path, msg = nil)
      msg = message(msg) { "Expected path '#{path}' not to exist" }
      assert !File.exist?(path), msg
    end
  end
end