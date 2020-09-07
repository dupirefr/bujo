module Plugins
  # Ruby
  require 'minitest/autorun'
  require 'fileutils'

  # Own
  require 'bujo/plugins/day_plugin'

  require_relative '../test_utils'

  class DayPluginTest < Minitest::Test
    def test_directory
      day_plugin = DayPlugin.new

      assert_equal("logs", day_plugin.directory)
    end

    def test_create_today
      execute_in_test_directory(-> (working_directory) {
        create_logs_directory

        Date.stub(:today, Date.strptime("01/09/2020", "%d/%m/%Y")) do
          day_plugin = DayPlugin.new
          day_plugin.create_today

          today_log_file_is_created(working_directory)
        end
      })
    end

    def test_create_tomorrow
      execute_in_test_directory(-> (working_directory) {
        create_logs_directory

        Date.stub(:today, Date.strptime("01/09/2020", "%d/%m/%Y")) do
          day_plugin = DayPlugin.new
          day_plugin.create_tomorrow

          tomorrow_log_file_is_created(working_directory)
        end
      })
    end

    def test_create_day
      execute_in_test_directory(-> (working_directory) {
        create_logs_directory

        day_plugin = DayPlugin.new
        day_plugin.create_day("03/09/2020")

        day_log_file_is_created(working_directory)
      })
    end

    private

    def create_logs_directory
      FileUtils.mkdir_p("src/logs")
    end

    def today_log_file_is_created(working_directory)
      file_is_created(working_directory, "src/logs/2020-09-01.adoc", "test/bujo/plugins/2020-09-01.adoc")
    end

    def tomorrow_log_file_is_created(working_directory)
      file_is_created(working_directory, "src/logs/2020-09-02.adoc", "test/bujo/plugins/2020-09-02.adoc")
    end

    def day_log_file_is_created(working_directory)
      file_is_created(working_directory, "src/logs/2020-09-03.adoc", "test/bujo/plugins/2020-09-03.adoc")
    end

    def file_is_created(working_directory, file_path, assets_file_path)
      assert_path_exists(file_path, "The file, #{file_path}, hasn't been created.")
      expected_file = File.read(File.join(working_directory, assets_file_path))
      actual_file = File.read(file_path)
      assert_equal(expected_file, actual_file, "The created file doesn't match the template.")
    end
  end
end