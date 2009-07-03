module ActiveApi
  module Elements
    class Date < Base

      protected

      def object_value
        value = object.send(options[:field])
        value.present? ? value.xmlschema : nil
      end

    end
  end
end