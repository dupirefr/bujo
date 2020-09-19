module Plugins
  # Own
  require 'bujo/plugins/plugin'
  require 'bujo/options/option'
  require 'bujo/utils/dates'
  require 'bujo/utils/files'

  class MonthPlugin < Plugin
    def initialize(dependencies = [])
      super("month", [
          Options::Option.builder
              .with_name("this-month")
              .with_description("Create an entry for this month in the journal")
              .with_action(-> { create_this_month })
              .build,
          Options::Option.builder
              .with_name("next-month")
              .with_description("Create an entry for next month in the journal")
              .with_action(-> { create_next_month })
              .build,
          Options::Option.builder
              .with_name("month")
              .with_description("Create an entry for the given month in the journal")
              .valued
              .with_action(lambda { |month| create_month(month) })
              .build
      ])

      @template_renderer = dependencies[:template_renderer]
    end

    def directory
      "logs"
    end

    def create_this_month
      puts "Creating an entry for this month (#{Utils::DateUtils.human_readable_month}) in the journal"
      do_create_month
    end

    def create_next_month
      puts "Creating an entry for next month (#{Utils::DateUtils.human_readable_month(Date.today.next_month)}) in the journal"
      do_create_month(Date.today.next_month)
    end

    def create_month(month_as_string)
      date = Utils::DateUtils.parse_human_readable_month(month_as_string)
      puts "Creating an entry for #{month_as_string} in the journal"
      do_create_month(date)
    end

    private

    def do_create_month(date = Date.today)
      rendered_template = @template_renderer.render("month/template.adoc", {
          :hr_month => Utils::DateUtils.human_readable_month(date),
          :cr_previous_month => Utils::DateUtils.computer_readable_month(date.prev_month),
          :cr_next_month => Utils::DateUtils.computer_readable_month(date.next_month)
      })
      month_source_path = Configuration::Structure.source_path("logs/#{Utils::DateUtils.computer_readable_month(date)}.adoc")
      Utils::Files.write(month_source_path, rendered_template)
    end
  end
end