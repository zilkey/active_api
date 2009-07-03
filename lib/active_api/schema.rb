module ActiveApi
  class Schema
    class_inheritable_array :definitions

    class << self
      def define(class_symbol)
        definition = Definition.new(class_symbol)
        yield definition
        write_inheritable_array :definitions, [definition]
      end
    end

  end
end