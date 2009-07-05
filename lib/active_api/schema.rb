# define :article do |t|
#   t.attribute  :author
#   t.parent     :author
#   t.string     :title
#   t.children   :comments
# end
#
# define :author do |t|
#   t.string   :name
#   t.children :articles
# end
# 
# define :comment do |t|
#   t.parent   :article
#   t.parent   :user
#   t.string   :text
# end
module ActiveApi
  class Schema
    class_inheritable_array :definitions

    class << self
      def define(name)
        definition = Definition.new :name => name
        yield definition
        write_inheritable_array :definitions, [definition]
      end
    end

  end
end