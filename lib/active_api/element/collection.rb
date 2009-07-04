module ActiveApi
  module Element
    class Collection

      attr_reader :objects, :node

      def initialize(objects, options)
        @objects  = objects
        @node     = options[:node]
      end

      def build_xml(_builder = Nokogiri::XML::Builder.new)
        _builder.tap do |builder|
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
end