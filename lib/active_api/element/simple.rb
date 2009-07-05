#:anyURI
#:base64Binary
#:boolean
#:date
#:dateTime
#      :dateTimeStamp
#:decimal
#      :integer
#            :long
#                  :int
#                        :short
#                              :byte
#            :nonNegativeInteger
#                  :positiveInteger
#                  :unsignedLong
#                        :unsignedInt
#                              :unsignedShort
#                                    :unsignedByte
#            :nonPositiveInteger
#                  :negativeInteger
#:double
#:duration
#      :dayTimeDuration
#      :yearMonthDuration
#:float
#:gDay
#:gMonth
#:gMonthDay
#:gYear
#:gYearMonth
#:hexBinary
#:NOTATION
#:precisionDecimal
#:QName
#:string
#      :normalizedString
#            :token
#                  :language
#                  :Name
#                        :NCName
#                              :ENTITY
#                              :ID
#                              :IDREF
#                  :NMTOKEN
#:time
module ActiveApi
  module Element
    class Simple
      include Builder

      class << self
        def formats
          [
            {:any_uri => :anyURI},
            :base64Binary,
            :boolean,
            :date,
            :dateTime,
            :dateTimeStamp,
            :decimal,
            :integer,
            :long,
            :int,
            :short,
            :byte,
            :nonNegativeInteger,
            :positiveInteger,
            :unsignedLong,
            :unsignedInt,
            :unsignedShort,
            :unsignedByte,
            :nonPositiveInteger,
            :negativeInteger,
            :double,
            :duration,
            :dayTimeDuration,
            :yearMonthDuration,
            :float,
            :gDay,
            :gMonth,
            :gMonthDay,
            :gYear,
            :gYearMonth,
            :hexBinary,
            {:notation => :NOTATION},
            :precisionDecimal,
            {:qname => :QName},
            :string,
            :normalizedString,
            :token,
            :language,
            {:name => :Name},
            {:nc_name => :NCName},
            {:entity => :ENTITY},
            {:id => :ID},
            {:idref => :IDREF},
            {:nmtoken => :NMTOKEN},
            :time
          ]
        end

        def default_format_proc
          proc { |value| value }
        end

        def format_procs
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
        (self.class.format_procs[format] || self.class.default_format_proc).call(text)
      end

    end
  end
end
