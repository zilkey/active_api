module ActiveApi
  class Field
    attr_reader :type, :name, :klass, :value, :choice, :field_type

    def initialize(options = {})
      @type         = options[:type]
      @name         = options[:name]
      @klass        = options[:klass]
      @value        = options[:value]
      @choice       = options[:choice]
      @field_type   = options[:field_type] || :element
    end

    def name_for(object)
      if choice
        value = object.send(name)
        return nil if value.nil?
        return choice[value.class.to_s]
      else
        name
      end
    end

  end
end