module ActiveApi
  class Courier
    attr_reader :ancestors, :node_name

    def initialize(options = {})
      @ancestors = [options[:parent]].compact
      @node_name = options[:node_name]
    end

    def singular_node_name

    end

    def plural_node_name

    end

  end
end