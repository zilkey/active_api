#date  	Defines a date value
#dateTime 	Defines a date and time value
#duration 	Defines a time interval
#gDay 	Defines a part of a date - the day (DD)
#gMonth 	Defines a part of a date - the month (MM)
#gMonthDay 	Defines a part of a date - the month and day (MM-DD)
#gYear 	Defines a part of a date - the year (YYYY)
#gYearMonth 	Defines a part of a date - the year and month (YYYY-MM)
#time 	Defines a time value

module ActiveApi
  module Xs
    class Time
#YYYY-MM-DDThh:mm:ss
      class << self
        def format(value)
          value.strftime("%Y")
        end
      end
    end
  end
end