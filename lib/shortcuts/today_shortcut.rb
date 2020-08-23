module Shortcuts
  # Own
  require_relative 'shortcut'
  require_relative '../utils/dates'

  include Utils

  class TodayShortcut < Shortcut
    def initialize
      super("Today", "logs/#{computer_readable_date}.html", "logs/today.html")
    end
  end
end