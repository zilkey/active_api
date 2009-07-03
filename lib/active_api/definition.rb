module ActiveApi
  class Definition
    attr_reader :class_symbol, :fields
    def initialize(class_symbol)
      @class_symbol = class_symbol
      @fields = []
    end

    def string(name)
      self.fields << Field.new(:type => :string, :name => name)
    end
  end
end