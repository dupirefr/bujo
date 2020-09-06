module Plugins
  # Own
  require 'bujo/plugins/plugin'
  require 'bujo/options/option'
  require 'bujo/templates/template_renderer'

  class DayPlugin < Plugin
    def initialize
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
    end

    def create_today
      puts "Creating an entry for today (#{human_readable_date}) in the journal"
      do_create_day
    end

    def create_tomorrow
      puts "Creating an entry for tomorrow (#{human_readable_date(Date.today.next_day)}) in the journal"
      do_create_day(Date.today.next_day)
    end

    def create_day(date_as_string)
      date = parse_human_readable_date(date_as_string)
      puts "Creating an entry for #{date_as_string} in the journal"
      do_create_day(date)
    end

    private

    def do_create_day(date = Date.today)
      rendered_template = Templates::TemplateRenderer.new.render("day/template.adoc", {
          :hr_day_long => human_readable_date(date),
          :hr_day_short => day(date),
          :hr_month => human_readable_month(date),
          :cr_previous_day => computer_readable_date(date.prev_day),
          :cr_next_day => computer_readable_date(date.next_day),
          :cr_month => computer_readable_month(date)
      })
      begin
        day_source_path = Configuration::Structure.source_path("logs/#{computer_readable_date(date)}.adoc")
        file = File.open(day_source_path, "w") { |file| file.puts(rendered_template) }
      ensure
        file.close unless file.nil?
      end
    end
  end
end