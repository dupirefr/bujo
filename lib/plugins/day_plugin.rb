module Plugins
  # Ruby
  require 'fileutils'

  class DayPlugin < Plugin
    def initialize
      super("day", [
          Option.builder
              .with_name("today")
              .with_description("Create an entry for today in the journal")
              .with_action(-> { DayPlugin.create_today })
              .build,
          Option.builder
              .with_name("tomorrow")
              .with_description("Create an entry for tomorrow in the journal")
              .with_action(-> { DayPlugin.create_tomorrow })
              .build
      ])
    end

    def self.create_today
      puts "Creating an entry for today (#{human_readable_date}) in the journal"
      FileUtils.copy("templates/logs/day.adoc.tpl", "src/logs/#{computer_readable_date}.adoc")
    end

    def self.create_tomorrow
      puts "Creating an entry for tomorrow (#{human_readable_date(Date.today.next_day)} in the journal"
      FileUtils.copy("templates/logs/day.adoc.tpl", "src/logs/#{computer_readable_date(Date.today.next_day)}.adoc")
    end
  end
end