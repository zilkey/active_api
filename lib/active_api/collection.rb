module ActiveApi
  class Collection
    attr_reader :objects
    def initialize(objects)
      @objects = objects
    end
  end
end