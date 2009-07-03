module ActiveApi
  module Nodes
    class Base

      attr_reader :options, :object

      def initialize(object, options = {})
        @object = object
        @options = options
      end

      def content
        return options[:value] if options.keys.include?(:value)
        return object.send(options[:field]) if options.keys.include?(:field)
        raise "You must specify either :field or :value"
      end

      def should_build?
        [].tap do |conditions|
          conditions << true
          conditions << false if object.nil?
          conditions << object.send(options[:if]) if options.has_key?(:if)
          conditions << !object.send(options[:unless]) if options.has_key?(:unless)
          conditions << false if options[:build_empty_nodes] == false && content.blank?
        end.all?{|condition| condition == true }
      end

    end
  end
end