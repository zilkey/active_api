module ActiveApi
  module Xs
    class Integer
      class << self
        def format(value)
          value.to_s
        end
      end
    end
  end
end