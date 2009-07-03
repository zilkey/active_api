module ActiveApi
  class Courier
    attr_reader :ancestors, :node_name

    def initialize(options = {})
      @ancestors = [options[:parent]].compact
      @node_name = options[:node_name]
    end

  end
end