module ActiveApi
  module Element
    class Simple
      include Builder

      attr_reader :text, :node

      def initialize(text, options)
        @text = text
        @node = options[:node]
      end

      protected

      def build(builder)
        builder.send "#{node}_", text
      end

    end
  end
end