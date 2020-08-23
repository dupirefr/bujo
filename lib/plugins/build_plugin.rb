module Plugins
  # Ruby
  require 'fileutils'

  # Own
  require_relative 'plugin'
  require_relative '../options/option'
  require_relative '../shortcuts/today_shortcut'
  require_relative '../shortcuts/this_month_shortcut'
  require_relative '../utils/configuration'

  include Options
  include Shortcuts
  include Utils

  class BuildPlugin < Plugin
    def initialize
      super("build", [
          Option.builder
              .with_name("i", "init")
              .with_description("Init the structure of the journal")
              .with_action(-> { init_journal })
              .build,
          Option.builder
              .with_name("b", "build")
              .with_description("Build HTML representation of the journal")
              .with_action(-> { build_journal })
              .with_shortcut(TodayShortcut.new)
              .with_shortcut(ThisMonthShortcut.new)
              .build
      ])
    end

    def self.create_index
      puts "Creating an index of the journal"
      FileUtils.copy("templates/index.adoc.tpl", "src/index.adoc")
    end

    private def init_journal
      puts "Initializing journal..."
      FileUtils.makedirs("src/logs")
      FileUtils.makedirs("src/projects")
      FileUtils.makedirs("src/collections")
      FileUtils.makedirs("target")
      BuildPlugin.create_index
      DayPlugin.create_today
      MonthPlugin.create_this_month
    end

    private def build_journal
      puts "Cleaning target..."
      FileUtils.remove_dir("target") if File.exist?("target")

      puts "Converting to HTML..."
      %x(asciidoctor #{Configuration.load.style.command}-R src -D target '**/*.adoc')
    end
  end
end