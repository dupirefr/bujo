require 'fileutils'

require_relative 'module'
require_relative '../options/option'
require_relative '../shortcuts/today-shortcut'
require_relative '../shortcuts/this-month-shortcut'

class EditionModule < Module
  def initialize
    super("edition", [
        OptionBuilder.new
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

    configuration = YAML.load_file("bujo.yaml")
    asciidoctor_command = "asciidoctor -R src -D target '#{file}'"
    asciidoctor_command = asciidoctor_command + "-a stylesdir=#{configuration['style']['directory']} -a stylesheet=#{configuration['style']['sheet']}.css" if configuration['sheet']['type'] == "custom"
    puts "Converting to HTML..."
    %x(#{asciidoctor_command})
  end
end