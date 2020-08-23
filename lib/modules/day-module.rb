require 'fileutils'

require_relative 'module'
require_relative '../options/option'
require_relative '../shortcuts/today-shortcut'
require_relative '../shortcuts/this-month-shortcut'
require_relative '../utils/bujo-dates'

class DayModule < Module
  def initialize
    super("day", [
        OptionBuilder.new
            .with_name("today")
            .with_description("Create an entry for today in the journal")
            .with_action(-> { DayModule.create_today })
            .build,
        OptionBuilder.new
            .with_name("tomorrow")
            .with_description("Create an entry for tomorrow in the journal")
            .with_action(-> { DayModule.create_tomorrow })
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