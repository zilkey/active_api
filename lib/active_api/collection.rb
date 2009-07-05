module ActiveApi
  class Collection
    include Builder
    include HasDefinition

    attr_reader :objects, :node, :parents, :schema

    def initialize(objects, options)
      @objects  = objects
      @node     = options[:node]
      @parents  = options[:parents]
      @schema   = options[:schema]
    end

    protected

    def build(builder)
      builder.send "#{node.to_s.pluralize}_" do |xml|
        objects.each do |object|
          element = definition.builder_class.constantize.new object,
                                                             :node => node,
                                                             :parents => parents,
                                                             :schema => schema
          element.build_xml(xml)
        end
      end
    end

  end
end