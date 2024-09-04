class CalendarComponent < ViewComponent::Base
  attr_reader :selected_date

  def initialize(selected_date: nil)
    @selected_date = selected_date || Date.today
  end

  def days_in_month
    Date.new(selected_date.year, selected_date.month, -1).day
  end

  def start_of_month
    selected_date.beginning_of_month.wday
  end

  def date_class(day)
    if selected_date.day == day
      'bg-blue-500 text-white hover:bg-blue-500'
    else
      'text-gray-800'
    end
  end
end
