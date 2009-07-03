require 'spec'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'active_api'
require 'faker'
require 'rr'

Spec::Runner.configure do |config|
  config.mock_with :rr
end

class Author
  attr_accessor :id, :name
end

class Article
  attr_accessor :id, :author_id, :title, :published_on
end

class User
  attr_accessor :id, :username
end

class Comment
  attr_accessor :id, :article_id, :user_id, :text
end

