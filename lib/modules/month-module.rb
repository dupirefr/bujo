require 'fileutils'

require_relative 'module'
require_relative '../options/option'
require_relative '../shortcuts/today-shortcut'
require_relative '../shortcuts/this-month-shortcut'
require_relative '../utils/bujo-dates'

class MonthModule < Module
  def initialize
    super("month", [
        OptionBuilder.new
            .with_name("this-month")
            .with_description("Create an entry for this month in the journal")
            .with_action(-> { MonthModule.create_this_month })
            .build,
        OptionBuilder.new
            .with_name("next-month")
            .with_description("Create an entry for next month in the journal")
            .with_action(-> { MonthModule.create_next_month })
            .build
    ])
  end

  def self.create_this_month
    puts "Creating an entry for this month (#{human_readable_month}) in the journal"
    FileUtils.copy("templates/logs/month.adoc.tpl", "src/logs/#{computer_readable_month}.adoc")
  end

  def self.create_next_month
    puts "Creating an entry for next month (#{human_readable_month(Date.today.next_month)}) in the journal"
    FileUtils.copy("templates/logs/month.adoc.tpl", "src/logs/#{computer_readable_month(Date.today.next_month)}.adoc")
  end
end