require 'fileutils'
require 'yaml'

require_relative 'module'
require_relative 'day-module'
require_relative 'month-module'
require_relative '../options/option'
require_relative '../shortcuts/today-shortcut'
require_relative '../shortcuts/this-month-shortcut'
require_relative '../utils/bujo-configuration'

class BuildModule < Module
  def initialize
    super("build", [
        OptionBuilder.new
            .with_name("i", "init")
            .with_description("Init the structure of the journal")
            .with_action(-> { init_journal })
            .build,
        OptionBuilder.new
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
    BuildModule.create_index
    DayModule.create_today
    MonthModule.create_this_month
  end

  private def build_journal
    puts "Cleaning target..."
    FileUtils.remove_dir("target") if File.exist?("target")

    puts "Converting to HTML..."
    %x("asciidoctor #{Configuration.instance.style.command}-R src -D target '**/*.adoc'")
  end
end