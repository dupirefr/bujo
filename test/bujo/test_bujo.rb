module Plugins
  # Ruby
  require 'minitest/autorun'

  # Own
  require 'bujo'

  require_relative 'test_utils'

  class BujoTest < Minitest::Test
    def test_init
      execute_in_test_directory(-> (working_directory) {
        parse %w[--init]

        assert_path_exists("bujo.yaml", "The configuration file, bujo.yaml, hasn't been created.")
        expected_configuration_file = File.read(File.join(working_directory, "assets/bujo/bujo.yaml"))
        actual_configuration_file = File.read("bujo.yaml")
        assert_equal(expected_configuration_file, actual_configuration_file, "The created configuration file doesn't match the template.")
      })
    end

    def test_build
      execute_in_test_directory(-> (working_directory) {
        create_config_file(working_directory)
        create_index_file

        parse %w[--build]

        index_file_is_created
      })
    end

    def create_config_file(working_directory)
      FileUtils.copy_file("#{working_directory}/bujo.yaml", "bujo.yaml")
    end

    def create_index_file
      FileUtils.mkdir("src")
      FileUtils.touch("src/index.adoc")
    end

    def index_file_is_created
      file_is_created("target/index.html")
    end

    def file_is_created(file_path)
      assert_path_exists(file_path, "The file, #{file_path}, hasn't been created.")
    end
  end
end