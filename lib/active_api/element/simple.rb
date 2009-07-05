#Token: A string that does not contain line feeds, carriage returns, tabs, leading or trailing spaces, or multiple spaces
#Normalized: A string that does not contain line feeds, carriage returns, or tabs
#byte  	A signed 8-bit integer
#decimal 	A decimal value
#int 	A signed 32-bit integer
#integer 	An integer value
#long 	A signed 64-bit integer
#negativeInteger 	An integer containing only negative values (..,-2,-1)
#nonNegativeInteger 	An integer containing only non-negative values (0,1,2,..)
#nonPositiveInteger 	An integer containing only non-positive values (..,-2,-1,0)
#positiveInteger 	An integer containing only positive values (1,2,..)
#short 	A signed 16-bit integer
#unsignedLong 	An unsigned 64-bit integer
#unsignedInt 	An unsigned 32-bit integer
#unsignedShort 	An unsigned 16-bit integer
#unsignedByte 	An unsigned 8-bit integer
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
  module Element
    class Simple
      include Builder

      class << self
        def default_format
          proc { |value| value }
        end

        def formats
          {
            :normalized_string => proc {|value| value },
            :token =>             proc {|value| value },
            :date_time =>         proc {|value| value.strftime("%Y-%m-%dT%H:%M:%S%Z") },
            :time =>              proc {|value| value.strftime("%H:%M:%S%Z") },
            :date =>              proc {|value| value.strftime("%Y-%m-%d") },
            :any_uri =>           proc {|value| URI.escape(value) }
          }
        end
      end

      attr_reader :text, :node, :format

      def initialize(text, options)
        @text   = text
        @node   = options[:node]
        @format = options[:format]
      end

      def append(hash)
        hash[node] = formatted_text
      end

      protected

      def build(builder)
        builder.send "#{node}_", formatted_text
      end

      def formatted_text
        (self.class.formats[format] || self.class.default_format).call(text)
      end

    end
  end
end