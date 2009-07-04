module ActiveApi
  class Field
    attr_reader :type, :name, :klass
    def initialize(options = {})
      @type   = options[:type]
      @name   = options[:name]
      @klass  = options[:klass]
    end
  end
end