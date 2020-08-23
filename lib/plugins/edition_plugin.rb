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

  class EditionPlugin < Plugin
    def initialize
      super("edition", [
          Option.builder
              .with_name("e", "edit")
              .with_description("Init the structure of the journal")
              .valued
              .with_action(lambda { |file| edit(file) })
              .with_shortcut(TodayShortcut.new)
              .with_shortcut(ThisMonthShortcut.new)
              .build
      ])
    end

    private def edit(file)
      puts "Editing entry..."
      system("vim #{file}")

      puts "Converting to HTML..."
      puts "asciidoctor #{Configuration.load.style.command} -R src -D target '#{file}'"
      system "asciidoctor #{Configuration.load.style.command} -R src -D target '#{file}'"
    end
  end
end