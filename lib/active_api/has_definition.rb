module ActiveApi
  module HasDefinition
    def definition
      schema.definitions.detect do |definition|
        definition.definition_name == node.to_s.singularize.to_sym
      end
    end
  end
end