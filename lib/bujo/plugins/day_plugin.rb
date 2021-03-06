module Plugins
  # Own
  require 'bujo/plugins/plugin'
  require 'bujo/options/option'
  require 'bujo/utils/dates'
  require 'bujo/utils/files'

  class DayPlugin < Plugin
    def initialize(dependencies = [])
      super("day", [
          Options::Option.builder
              .with_name("today")
              .with_description("Create an entry for today in the journal")
              .with_action(-> { create_today })
              .build,
          Options::Option.builder
              .with_name("tomorrow")
              .with_description("Create an entry for tomorrow in the journal")
              .with_action(-> { create_tomorrow })
              .build,
          Options::Option.builder
              .with_name("date")
              .with_description("Create an entry for the given date in the journal")
              .valued
              .with_action(lambda { |value| create_day(value) })
              .build
      ])

      @template_renderer = dependencies[:template_renderer]
    end

    def directory
      "logs"
    end

    def create_today
      puts "Creating an entry for today (#{Utils::DateUtils.human_readable_date}) in the journal"
      do_create_day
    end

    def create_tomorrow
      puts "Creating an entry for tomorrow (#{Utils::DateUtils.human_readable_date(Date.today.next_day)}) in the journal"
      do_create_day(Date.today.next_day)
    end

    def create_day(date_as_string)
      date = Utils::DateUtils.parse_human_readable_date(date_as_string)
      puts "Creating an entry for #{date_as_string} in the journal"
      do_create_day(date)
    end

    private

    def do_create_day(date = Date.today)
      rendered_template = @template_renderer.render("day/template.adoc", {
          :hr_day_long => Utils::DateUtils.human_readable_date(date),
          :hr_day_short => Utils::DateUtils.day(date),
          :hr_month => Utils::DateUtils.human_readable_month(date),
          :cr_previous_day => Utils::DateUtils.computer_readable_date(date.prev_day),
          :cr_next_day => Utils::DateUtils.computer_readable_date(date.next_day),
          :cr_month => Utils::DateUtils.computer_readable_month(date)
      })
      day_source_path = Configuration::Structure.source_path("logs/#{Utils::DateUtils.computer_readable_date(date)}.adoc")
      Utils::Files.write(day_source_path, rendered_template)
    end
  end
end