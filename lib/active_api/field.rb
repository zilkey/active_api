module ActiveApi
  class Field
    attr_reader :type, :name, :klass, :value, :polymorphic

    def initialize(options = {})
      @type         = options[:type]
      @name         = options[:name]
      @klass        = options[:klass]
      @value        = options[:value]
      @polymorphic  = options[:polymorphic]
    end

    def name_for(object)
      if polymorphic
        value = object.send(name)
        return nil if value.nil?
        return polymorphic[value.class.to_s]
      else
        name
      end
    end

  end
end