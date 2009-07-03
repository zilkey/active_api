module ActiveApi
  class Element
    attr_reader :object, :options
    def initialize(object, options = {})
      @object = object
      @options = options
    end

    def node_name
      name = options[:node_name]
      name = (object ? object.class.to_s.underscore : nil) if name.nil?
      name
    end
  end
end