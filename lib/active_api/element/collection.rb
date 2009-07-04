module ActiveApi
  module Element
    class Collection

      attr_reader :objects, :node

      def initialize(objects, options)
        @objects  = objects
        @node     = options[:node]
      end

      def build_xml(builder = Nokogiri::XML::Builder.new)
        builder.send node.to_s.pluralize do |xml|
          objects.each do |object|
            element = Complex.new object, :node => node
            element.build_xml(xml)
          end
        end
        builder
      end

    end
  end
end