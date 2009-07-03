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

    def build_xml(builder = Nokogiri::XML::Builder.new)
      builder
      #builder.send node_name, :id => object.id do |xml|
      #  self.class.attributes.each do |type, options|
      #    formatter(type).new(object, options.merge(api_options)).build_xml(xml)
      #  end
      #end
      #builder
    end

  end
end