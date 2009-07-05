module ActiveApi
  class Definition
    attr_reader :name, :fields

    def initialize(options)
      @name   = options[:name]
      @fields = options[:fields] || []
    end

    def attribute(name, type = :string, options = {})
      field options.merge(:name => name, :type => type, :field_type => :attribute)
    end

    def string(name, options = {})
      field options.merge(:name => name, :type => :string, :klass => Element::Simple)
    end

    def belongs_to(name, options = {})
      field options.merge(:name => name, :type => :belongs_to, :klass => Element::Complex)
    end

    def has_one(name, options = {})
      field options.merge(:name => name, :type => :has_one, :klass => Element::Complex)
    end

    def has_many(name, options = {})
      field options.merge(:name => name, :type => :has_many, :klass => Element::Collection)
    end

    def element(name, type, options = {})
      send type, name, options
    end

    def field(options)
      self.fields << Field.new(options)
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

  end
end