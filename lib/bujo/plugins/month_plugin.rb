module Plugins
  # Own
  require 'bujo/plugins/plugin'
  require 'bujo/options/option'

  class MonthPlugin < Plugin
    def initialize
      super("month", [
          Options::Option.builder
              .with_name("this-month")
              .with_description("Create an entry for this month in the journal")
              .with_action(-> { MonthPlugin.create_this_month })
              .build,
          Options::Option.builder
              .with_name("next-month")
              .with_description("Create an entry for next month in the journal")
              .with_action(-> { MonthPlugin.create_next_month })
              .build
      ])
    end

    def self.create_this_month
      puts "Creating an entry for this month (#{human_readable_month}) in the journal"
    end

    def self.create_next_month
      puts "Creating an entry for next month (#{human_readable_month(Date.today.next_month)}) in the journal"
    end
  end
end