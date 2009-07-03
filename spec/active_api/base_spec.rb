require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

class SomeData
  attr_accessor :id, :name
end

describe ActiveApi::Base do

  before do
    @some_object = SomeData.new
    @some_object.id = 1
    @some_object.name = "some name"
  end

  it "should initialize" do
    api = ActiveApi::Base.new(@some_object)
    api.object.should == @some_object
  end

end