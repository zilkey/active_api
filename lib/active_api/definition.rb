module ActiveApi
  class Definition
    attr_reader :definition_name, :fields, :builder_class

    def initialize(options)
      @definition_name  = options[:definition_name]
      @builder_class    = options[:builder_class] || ComplexType.to_s
      @fields           = options[:fields] || []
    end

    def attribute(*args)
      options = args.extract_options!
      options[:type] ||= :string
      options.merge! :name => args.first, 
                     :field_type => :attribute
      field options
    end

    def element(name, type = :string, options = {})
      send type, name, options
    end

    SimpleType.formats.each do |hash|
      hash.each do |standard_name, xml_name|
        define_method standard_name do |name, *options|
          options = options.first || {}
          field options.merge(:name => name, :type => standard_name, :klass => SimpleType)
        end

        if standard_name != xml_name
          define_method xml_name do |name, *options|
            options = options.first || {}
            field options.merge(:name => name, :type => standard_name, :klass => SimpleType)
          end
        end
      end
    end

    def belongs_to(name, options = {})
      field options.merge(:name => name, :type => :belongs_to, :klass => ComplexType)
    end

    def has_one(name, options = {})
      field options.merge(:name => name, :type => :has_one, :klass => ComplexType)
    end

    def has_many(name, options = {})
      field options.merge(:name => name, :type => :has_many, :klass => Collection)
    end

    def attributes
      fields.select do |field|
        field.field_type == :attribute
      end
    end

    def elements
      fields.select do |field|
        field.field_type == :element
      end
    end

    def singular_name
      name.to_s.singularize
    end

    def plural_name
      name.to_s.pluralize
    end

    private

    def field(options)
      self.fields << Field.new(options)
    end
    
  end
end