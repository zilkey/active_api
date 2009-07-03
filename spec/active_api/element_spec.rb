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

    it "stores options" do
      api = ActiveApi::Element.new(@some_object, {:foo => :bar})
      api.options.should == {:foo => :bar}
    end
  end

  describe "#node_name" do
    context "when the object is nil, and the node_name is not passed" do
      it "returns nil" do
        api = ActiveApi::Element.new(nil)
        api.node_name.should be_nil
      end
    end

    context "when the object is not nil" do
      it "assumes the name of the object" do
        api = ActiveApi::Element.new(@some_object)
        api.node_name.should == "some_data"
      end
    end

    context "when the object is nil and node_name was passed" do
      it "assumes the name of the object" do
        api = ActiveApi::Element.new(nil, :node_name => "foo")
        api.node_name.should == "foo"
      end
    end

    context "when the object is not nil and node_name was passed" do
      it "uses the node name" do
        api = ActiveApi::Element.new(@some_object, :node_name => "foo")
        api.node_name.should == "foo"
      end
    end
  end

end