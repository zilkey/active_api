require 'spec'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'active_api'

Spec::Runner.configure do |config|
  
end

class Author
  attr_accessor :id, :name
end

class Article
  attr_accessor :id, :author_id, :title
end

class User
  attr_accessor :id, :username
end

class Comment
  attr_accessor :id, :article_id, :user_id, :text
end

