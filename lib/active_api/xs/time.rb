module ActiveApi
  module Xs
    class Time
      #hh:mm:ss
      #09:30:10.5
      class << self
        def format(value)
          value.strftime("%Y")
        end
      end
    end
  end
end