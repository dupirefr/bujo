module Plugins
  # Ruby
  require 'fileutils'

  # Own
  require_relative 'plugin'
  require_relative '../options/option'
  require_relative '../utils/assets'

  class InitPlugin < Plugin
    def initialize
      super("init", [
          Options::Option.builder
              .with_name("i", "init")
              .with_description("Init the structure of the journal")
              .with_action(-> { init_journal })
              .build
      ])
    end

    private def init_journal
      puts "Initializing a new journal..."
      FileUtils.copy(Assets.get("bujo/bujo.yaml"), "bujo.yaml")
    end
  end
end