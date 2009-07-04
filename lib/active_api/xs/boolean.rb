module ActiveApi
  module Xs
    class Boolean
      class << self
        def format(value)
          value.to_s
        end
      end
    end
  end
end