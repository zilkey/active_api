module ActiveApi
  class ComplexType
    include Builder
    include HasDefinition

    attr_reader :object, :node, :parents, :schema

    def initialize(object, options = {})
      @object = object
      @node   = options[:node]
      @parents = options[:parents] || {}
      @parents[node.to_s.singularize.to_sym] = object
      @schema = options[:schema]
    end

    protected

    def build(builder)
      builder.send "#{node.to_s.singularize}_", attributes do |xml|
        definition.elements.each do |field|
          name = field.name_for(object)
          if name.present?
            element = field.klass.new value(field),
                                      :node => name,
                                      :parents => parents,
                                      :format => field.type,
                                      :schema => schema
            element.build_xml(xml)
          end
        end
      end
    end

    def attributes
      {}.tap do |attributes|
        definition.attributes.each do |field|
          name = field.name_for(object)
          attribute = SimpleType.new value(field),
                                     :node => name,
                                     :format => field.type
          attribute.append(attributes)
        end
      end
    end

    def value(field)
      if field.value.nil?
        object.send(field.name)
      elsif field.value.is_a?(Symbol)
        object.send(field.value)
      elsif field.value.is_a?(String)
        field.value
      else
        field.value.call(self)
      end
    end
  end
end