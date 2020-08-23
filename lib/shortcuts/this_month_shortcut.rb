module Shortcuts
  class ThisMonthShortcut < Shortcut
    def initialize
      super("This month", "logs/#{computer_readable_month}.html", "logs/this_month.html")
    end
  end
end