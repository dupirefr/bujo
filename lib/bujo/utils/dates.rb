module Utils
  require 'date'

  def human_readable_date(date = Date.today)
    date.strftime("%d/%m/%Y")
  end

  def human_readable_month(date = Date.today)
    date.strftime("%m/%Y")
  end

  def computer_readable_date(date = Date.today)
    date.strftime("%Y-%m-%d")
  end

  def computer_readable_month(date = Date.today)
    date.strftime("%Y-%m")
  end
end