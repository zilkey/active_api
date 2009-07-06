require 'spec'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'active_api'
require 'faker'
require 'rr'
require 'domain'

module SchemaHelper
  def reset_schema
    ActiveApi::Schema.reset_inheritable_attributes
    ActiveApi::Schema.versions = []
  end
end

Spec::Runner.configure do |config|
  config.mock_with :rr
  config.include SchemaHelper
  config.before(:each) { reset_schema }
end
