module ActiveApi
  class Base
    attr_reader :object, :objects, :options, :parent
    def initialize(object_or_array, options = {})
      @objects = [object_or_array].flatten.compact
      @object = @objects.first
      @options = options
      @parent = options[:parent]
    end

    def courier
      Courier.new(options)
    end

    def node_name
      name = options[:node_name]
      name = (@object.present? ? @object.class.to_s.underscore.downcase : nil ) if name.nil?
      name
    end
  end
end