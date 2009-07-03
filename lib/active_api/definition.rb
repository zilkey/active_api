module ActiveApi
  class Definition
    attr_reader :class_symbol, :fields
    def initialize(class_symbol)
      @class_symbol = class_symbol
      @fields = []
    end

    [:string, :date, :datetime, :reference, :collection].each do |method_name|
      define_method method_name do |name, *args|
        options = args.first || Hash.new
        field options.merge(:name => name, :type => method_name)
      end
    end

    def field(options)
      self.fields << Field.new(options)
    end
  end
end