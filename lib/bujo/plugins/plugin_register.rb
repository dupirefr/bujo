module Plugins
  # Ruby
  require 'optparse'

  # Own
  require_relative 'init_plugin'

  class PluginRegister
    private def initialize(plugins = [])
      @plugins = plugins
    end

    def self.default
      PluginRegister.new([
                             InitPlugin.new
      ])
    end

    def register(plugin)
      puts "Registering #{plugin.name} plugin..."
      @plugins << plugin
      self
    end

    def create_shortcuts(shortcuts)
      puts "Creating shortcuts..." unless shortcuts.empty?
      shortcuts.each do |shortcut|
        shortcut.create
      end
    end

    def parse(options)
      OptionParser.new do |parser|
        parser.banner = "Usage: bujo [options]"

        @plugins.each { |mod|
          mod.options.each { |option|
            parser.on("--" + option.long_name + " VALUE", option.description) do |value|
              option.action.call(value)
              create_shortcuts(option.shortcuts)
            end if option.short_name.nil? && option.valued

            parser.on("-" + option.short_name, "--" + option.long_name + " VALUE", option.description) do |value|
              option.action.call(value)
              create_shortcuts(option.shortcuts)
            end if !option.short_name.nil? && option.valued

            parser.on("--" + option.long_name, option.description) do ||
              option.action.call
              create_shortcuts(option.shortcuts)
            end if option.short_name.nil? && !option.valued

            parser.on("-" + option.short_name, "--" + option.long_name, option.description) do ||
              option.action.call
              create_shortcuts(option.shortcuts)
            end if !option.short_name.nil? && !option.valued
          }
        }
        parser.on("-h", "--help", "Show this help message") do ||
          puts parser
        end
      end.parse!(options)
    end
  end
end