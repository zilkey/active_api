module ActiveApi
  module Xs
    class Date
      class << self
        #YYYY-MM-DD
        #2002-09-24Z
        #2002-09-24-06:00
        #2002-09-24+06:00
        def format(value)
          value.strftime("%Y")
        end
      end
    end
  end
end