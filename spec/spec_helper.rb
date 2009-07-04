require 'spec'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'active_api'
require 'faker'
require 'rr'
require 'domain'

Spec::Runner.configure do |config|
  config.mock_with :rr
end

