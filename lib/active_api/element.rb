module ActiveApi
  class Element
    attr_reader :object
    def initialize(object)
      @object = object
    end
  end
end