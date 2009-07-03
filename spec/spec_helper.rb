require 'spec'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'active_api'

Spec::Runner.configure do |config|
  
end

class SomeData
  attr_accessor :id, :name
end
