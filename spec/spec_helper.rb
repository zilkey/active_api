require 'spec'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'active_api'
require 'faker'
require 'rr'

Spec::Runner.configure do |config|
  config.mock_with :rr
end

class ObjectHelper
  class << self
    def fields(*args)
      args.each do |field|
        field(field)
      end
    end

    private

    def field(field_name)
      define_method field_name do
        attributes[field_name]
      end
      define_method "#{field_name}=" do |value|
        attributes[field_name] = value
      end
    end
  end

  attr_reader :attributes
  def initialize(options = {})
    @attributes = options
  end

end

class Author < ObjectHelper
  fields :id, :name
end

class Article < ObjectHelper
  fields :id, :author, :title, :published_on, :comments
end

class User < ObjectHelper
  fields :id, :username
end

class Comment < ObjectHelper
  fields :id, :article, :user, :text
end

