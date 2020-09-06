module Utils
  require 'date'

  class DateUtils
    def self.day(date = Date.today)
      date.strftime("%d")
    end

    def self.human_readable_date(date = Date.today)
      date.strftime("%d/%m/%Y")
    end

    def self.human_readable_month(date = Date.today)
      date.strftime("%m/%Y")
    end

    def self.computer_readable_date(date = Date.today)
      date.strftime("%Y-%m-%d")
    end

    def self.computer_readable_month(date = Date.today)
      date.strftime("%Y-%m")
    end

    def self.parse_human_readable_date(date_as_string)
      Date.strptime(date_as_string, "%d/%m/%Y")
    end

    def self.parse_human_readable_month(month_as_string)
      Date.strptime("01/#{month_as_string}", "%d/%m/%Y")
    end
  end
end