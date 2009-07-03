module ActiveApi
  class Field
    attr_reader :type, :name
    def initialize(options = {})
      @type = options[:type]
      @name = options[:name]
    end
  end
end