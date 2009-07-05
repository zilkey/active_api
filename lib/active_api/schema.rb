module ActiveApi

  class Schema
    class_inheritable_array :versions

    class << self
      def version(version)
        schema = Schema.new version
        yield schema
        write_inheritable_array :versions, [schema]
        schema
      end

      def find(version)
        versions.detect { |schema| schema.version == version }
      end
    end

    attr_reader :version, :definitions
    def initialize(version)
      @version     = version
      @definitions = []
    end

    def define(name, options = {})
      options[:definition_name] = name
      definition = Definition.new options
      yield definition if block_given?
      definitions << definition
    end

    def build_xml(objects, options)
      Collection.new(objects, options.merge(:schema => self)).build_xml
    end

  end
end