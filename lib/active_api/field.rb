module ActiveApi
  class Field
    attr_reader :type, :name, :klass, :value
    def initialize(options = {})
      @type   = options[:type]
      @name   = options[:name]
      @klass  = options[:klass]
      @value  = options[:value]
    end
  end
end