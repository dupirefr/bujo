module Plugins
  # Ruby
  require 'minitest/autorun'
  require 'fileutils'

  # Own
  require 'bujo/plugins/project_plugin'

  require_relative '../test_utils'

  class ProjectPluginTest < Minitest::Test
    def test_directory
      project_plugin = ProjectPlugin.new

      assert_equal("projects", project_plugin.directory)
    end

    def test_create_project_single_word
      execute_in_test_directory(-> (working_directory) {
        create_projects_directory

        project_plugin = ProjectPlugin.new
        project_plugin.create_project("House")

        project_file_is_created(working_directory, "house")
      })
    end

    def test_create_project_multiple_words
      execute_in_test_directory(-> (working_directory) {
        create_projects_directory

        project_plugin = ProjectPlugin.new
        project_plugin.create_project("Buy house")

        project_file_is_created(working_directory, "buy_house")
      })
    end

    private

    def create_projects_directory
      FileUtils.mkdir_p("src/projects")
    end

    def project_file_is_created(working_directory, project_file_name)
      file_is_created(working_directory, "src/projects/#{project_file_name}.adoc", "test/bujo/plugins/#{project_file_name}.adoc")
    end

    def file_is_created(working_directory, file_path, assets_file_path)
      assert_path_exists(file_path, "The file, #{file_path}, hasn't been created.")
      expected_file = File.read(File.join(working_directory, assets_file_path))
      actual_file = File.read(file_path)
      assert_equal(expected_file, actual_file, "The created file doesn't match the template.")
    end
  end
end