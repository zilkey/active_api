module ActiveApi

  class Schema
    class_inheritable_array :versions

    class << self
      def version(version, options = {})
        options[:definition_class] ||= Definition
        schema = Schema.new version, options
        yield schema
        write_inheritable_array :versions, [schema]
        schema
      end

      def find(version)
        versions.detect { |schema| schema.version == version }
      end
    end

    attr_reader :version, :definitions, :definition_class
    def initialize(version, options = {})
      @version     = version
      @definitions = []
      @definition_class = options[:definition_class]
    end

    def define(name, options = {})
      options[:definition_name] = name
      definition = definition_class.to_s.constantize.new options
      yield definition if block_given?
      definitions << definition
    end

    def build_xml(objects, options)
      Collection.new(objects, options.merge(:schema => self)).build_xml
    end

  end
end