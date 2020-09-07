module Plugins
  # Ruby
  require 'minitest/autorun'
  require 'fileutils'

  # Own
  require 'bujo/plugins/month_plugin'

  require_relative '../test_utils'

  class MonthPluginTest < Minitest::Test
    def test_directory
      month_plugin = MonthPlugin.new

      assert_equal("logs", month_plugin.directory)
    end

    def test_create_this_month
      execute_in_test_directory(-> (working_directory) {
        create_logs_directory

        Date.stub(:today, Date.strptime("01/09/2020", "%d/%m/%Y")) do
          month_plugin = MonthPlugin.new
          month_plugin.create_this_month

          this_month_log_file_is_created(working_directory)
        end
      })
    end

    def test_create_next_month
      execute_in_test_directory(-> (working_directory) {
        create_logs_directory

        Date.stub(:today, Date.strptime("01/09/2020", "%d/%m/%Y")) do
          month_plugin = MonthPlugin.new
          month_plugin.create_next_month

          next_month_log_file_is_created(working_directory)
        end
      })
    end

    def test_create_month
      execute_in_test_directory(-> (working_directory) {
        create_logs_directory

        month_plugin = MonthPlugin.new
        month_plugin.create_month("12/2020")

        month_log_file_is_created(working_directory)
      })
    end

    private

    def create_logs_directory
      FileUtils.mkdir_p("src/logs")
    end

    def this_month_log_file_is_created(working_directory)
      file_is_created(working_directory, "src/logs/2020-09.adoc", "test/bujo/plugins/2020-09.adoc")
    end

    def next_month_log_file_is_created(working_directory)
      file_is_created(working_directory, "src/logs/2020-10.adoc", "test/bujo/plugins/2020-10.adoc")
    end

    def month_log_file_is_created(working_directory)
      file_is_created(working_directory, "src/logs/2020-12.adoc", "test/bujo/plugins/2020-12.adoc")
    end

    def file_is_created(working_directory, file_path, assets_file_path)
      assert_path_exists(file_path, "The file, #{file_path}, hasn't been created.")
      expected_file = File.read(File.join(working_directory, assets_file_path))
      actual_file = File.read(file_path)
      assert_equal(expected_file, actual_file, "The created file doesn't match the template.")
    end
  end
end