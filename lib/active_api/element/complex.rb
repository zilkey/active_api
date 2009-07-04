module ActiveApi
  module Element
    class Complex

      attr_reader :object, :node, :name

      def initialize(object, options = {})
        @object = object
        @node   = options[:node]
        @name   = options[:name]
      end

      def build_xml(builder = Nokogiri::XML::Builder.new)
        builder.send node.to_s.singularize do |xml|
          definition = Schema.definitions.detect{|definition| definition.name == node}
          definition.fields.each do |field|
            puts field.inspect
            element = field.klass.new object.send(field.name), :node => node, :name => name
            element.build_xml(xml)
          end
        end
        builder
      end

    end
  end
end