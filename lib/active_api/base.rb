module ActiveApi
  class Base
    attr_reader :object
    def initialize(object)
      @object = object
    end
  end
end