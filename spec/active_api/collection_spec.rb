require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ActiveApi::Element do

  before do
    @some_object = SomeData.new
    @some_object.id = 1
    @some_object.name = "some name"
  end

end