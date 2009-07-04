module ActiveApi
  module Element
    class Complex
      include Builder

      attr_reader :object, :node

      def initialize(object, options = {})
        @object = object
        @node   = options[:node]
      end

      protected

      def build(builder)
        builder.send node.to_s.singularize do |xml|
          definition = Schema.definitions.detect{|definition| definition.name == node}
          definition.fields.each do |field|
            element = field.klass.new object.send(field.name), :node => field.name
            element.build_xml(xml)
          end
        end
      end

    end
  end
end