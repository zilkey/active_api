module ActiveApi
  class SimpleType
    include Builder

    class << self
      def formats
        standard_names = [
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
          :precisionDecimal,
          :string,
          :normalizedString,
          :token,
          :language,
          :time
        ].map do |format|
          {format.to_s.underscore.to_sym => format}
        end

        custom_names = [
          {:any_uri => :anyURI},
          {:notation => :NOTATION},
          {:qname => :QName},
          {:name => :Name},
          {:nc_name => :NCName},
          {:entity => :ENTITY},
          {:id => :ID},
          {:idref => :IDREF},
          {:nmtoken => :NMTOKEN},
        ]

        standard_names + custom_names
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
