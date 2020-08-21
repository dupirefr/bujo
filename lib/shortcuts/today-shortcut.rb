require_relative 'shortcut'
require_relative '../utils/journal-dates'

class TodayShortcut < Shortcut
  def initialize
    super("Today", "logs/#{computer_readable_date}.html", "logs/today.html")
  end
end