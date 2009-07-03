require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ActiveApi::Element do

  before do
    @some_object = SomeData.new
    @some_object.id = 1
    @some_object.name = "some name"
  end

  describe ".new" do
    it "should return a nil object when nil" do
      api = ActiveApi::Element.new(nil)
      api.object.should be_nil
    end

    it "should return the object when not nil" do
      api = ActiveApi::Element.new(@some_object)
      api.object.should == @some_object
    end
  end

end