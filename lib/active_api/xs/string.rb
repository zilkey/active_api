#ENTITIES
#ENTITY
#ID 	A string that represents the ID attribute in XML (only used with schema attributes)
#IDREF 	A string that represents the IDREF attribute in XML (only used with schema attributes)
#IDREFS
#language 	A string that contains a valid language id
#Name 	A string that contains a valid XML name
#NCName
#NMTOKEN 	A string that represents the NMTOKEN attribute in XML (only used with schema attributes)
#NMTOKENS
#normalizedString 	A string that does not contain line feeds, carriage returns, or tabs
#QName
#string 	A string
#token 	A string that does not contain line feeds, carriage returns, tabs, leading or trailing spaces, or multiple spaces

module ActiveApi
  module Xs
    class String
      class << self
        def format(value)
          value
        end
      end
    end
  end
end