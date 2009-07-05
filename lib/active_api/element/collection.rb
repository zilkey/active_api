module ActiveApi
  module Element
    class Collection
      include Builder

      attr_reader :objects, :node, :parents

      def initialize(objects, options)
        @objects  = objects
        @node     = options[:node]
        @parents  = options[:parents]
      end

      protected

      def build(builder)
        builder.send "#{node.to_s.pluralize}_" do |xml|
          objects.each do |object|
            element = Complex.new object, :node => node, :parents => parents
            element.build_xml(xml)
          end
        end
      end

    end
  end
end