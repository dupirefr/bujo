module Plugins
  # Ruby
  require 'minitest/autorun'

  # Own
  require 'bujo/plugins/init_plugin'
  require 'bujo/templates/template_renderer'

  require_relative '../test_utils'

  class InitPluginTest < Minitest::Test
    def test_init_journal
      execute_in_test_directory(-> (working_directory) {
        init_plugin = InitPlugin.new({template_renderer: Templates::TemplateRenderer.new})
        init_plugin.init_journal

        configuration_file_is_copied(working_directory)
        index_file_is_copied(working_directory)
      })
    end

    private

    def configuration_file_is_copied(working_directory)
      file_is_copied(working_directory, "bujo.yaml", "assets/bujo/bujo.yaml")
    end

    def index_file_is_copied(working_directory)
      file_is_copied(working_directory, "src/index.adoc", "assets/bujo/plugins/init/template.adoc")
    end

    def file_is_copied(working_directory, file_path, assets_file_path)
      assert_path_exists(file_path, "The file, #{file_path}, hasn't been created.")
      expected_file = File.read(File.join(working_directory, assets_file_path))
      actual_file = File.read(file_path)
      assert_equal(expected_file, actual_file, "The created file doesn't match the template.")
    end
  end
end