module ActiveApi
  module Elements
    class Base
      attr_reader :object, :objects, :options, :parent

      def initialize(object_or_array, options = {})
        @objects = [object_or_array].flatten.compact
        @object = @objects.first
        @options = options
        @parent = options[:parent]
      end

      def fields
        fields = [options[:fields]].flatten.compact
      end

      def courier
        Courier.new(options)
      end

      def content
        return options[:value] if options.keys.include?(:value)
        return object_value if options.keys.include?(:field)
        raise "You must specify either :field or :value"
      end

      def node_name
        name = options[:node_name]
        name = (@object.present? ? @object.class.to_s.underscore.downcase : nil ) if name.nil?
        name
      end

      def build_xml(builder = Nokogiri::XML::Builder.new)
        builder.send node_name do |xml|
          fields.each do |field|
            xml.send field.name, object.send(field.name)
          end
        end
        builder
      end

      def should_build?
        [].tap do |conditions|
          conditions << true
          conditions << false if object.nil?
          conditions << object.send(options[:if]) if options.has_key?(:if)
          conditions << !object.send(options[:unless]) if options.has_key?(:unless)
          conditions << false if options[:build_empty_nodes] == false && content.blank?
        end.all?{|condition| condition == true }
      end

      protected

      def object_value
        object.send(options[:field])
      end
    end
  end
end