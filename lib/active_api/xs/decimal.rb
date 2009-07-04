#byte  	A signed 8-bit integer
#decimal 	A decimal value
#int 	A signed 32-bit integer
#integer 	An integer value
#long 	A signed 64-bit integer
#negativeInteger 	An integer containing only negative values (..,-2,-1)
#nonNegativeInteger 	An integer containing only non-negative values (0,1,2,..)
#nonPositiveInteger 	An integer containing only non-positive values (..,-2,-1,0)
#positiveInteger 	An integer containing only positive values (1,2,..)
#short 	A signed 16-bit integer
#unsignedLong 	An unsigned 64-bit integer
#unsignedInt 	An unsigned 32-bit integer
#unsignedShort 	An unsigned 16-bit integer
#unsignedByte 	An unsigned 8-bit integer
module ActiveApi
  module Xs
    class Decimal
      class << self
        def format(value)
          value.to_s
        end
      end
    end
  end
end