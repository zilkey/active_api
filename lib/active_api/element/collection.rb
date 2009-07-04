module ActiveApi
  module Element
    class Collection
      include Builder

      attr_reader :objects, :node

      def initialize(objects, options)
        @objects  = objects
        @node     = options[:node]
      end

      protected

      def build(builder)
        builder.send node.to_s.pluralize do |xml|
          objects.each do |object|
            element = Complex.new object, :node => node
            element.build_xml(xml)
          end
        end
      end

    end
  end
end