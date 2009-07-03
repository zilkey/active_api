require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ActiveApi::Base do

  before do
    @some_object = SomeData.new
    @some_object.id = 1
    @some_object.name = "some name"
  end

  describe ".new" do
    it "sets options" do
      api = ActiveApi::Base.new(nil, :foo => :bar)
      api.options.should == {:foo => :bar}
    end
  end

  describe "#objects" do
    context "when passed an array" do
      it "should return an empty array when passed an empty array" do
        api = ActiveApi::Base.new([])
        api.objects.should be_empty
      end

      it "should return the array when given a non-empty array" do
        api = ActiveApi::Base.new([@some_object])
        api.objects.should == [@some_object]
      end
    end

    context "when passed an element" do
      it "should return an empty array when passed nil" do
        api = ActiveApi::Base.new(nil)
        api.objects.should be_empty
      end

      it "should return an array of the object when given an object" do
        api = ActiveApi::Base.new(@some_object)
        api.objects.should == [@some_object]
      end
    end
  end

  describe "#object" do
    context "when passed an array" do
      it "should return nil when passed an empty array" do
        api = ActiveApi::Base.new([])
        api.object.should be_nil
      end

      it "should return the first object in the array when given a non-empty array" do
        @some_other_object = SomeData.new
        @some_other_object.id = 2
        api = ActiveApi::Base.new([@some_object, @some_other_object])
        api.object.should == @some_object
      end
    end

    context "when passed an object" do
      it "should return nil when passed nil" do
        api = ActiveApi::Base.new(nil)
        api.object.should be_nil
      end

      it "should return the object when given an object" do
        api = ActiveApi::Base.new(@some_object)
        api.object.should == @some_object
      end
    end
  end

  describe "#node_name" do
    context "when the array is empty, and the node_name is not passed" do
      it "returns nil" do
        api = ActiveApi::Base.new([])
        api.node_name.should be_nil
      end
    end

    context "when the object is nil, and the node_name is not passed" do
      it "returns nil" do
        api = ActiveApi::Base.new(nil)
        api.node_name.should be_nil
      end
    end

    context "when the array is not empty, and the node name is not passed" do
      it "returns the name of the first object in the array" do
        api = ActiveApi::Base.new([@some_object])
        api.node_name.should == "some_data"
      end
    end

    context "when the object is not nil" do
      it "returns the name of the object" do
        api = ActiveApi::Base.new(@some_object)
        api.node_name.should == "some_data"
      end
    end

    context "when the array is empty and node_name was passed" do
      it "returns the passed in node name" do
        api = ActiveApi::Base.new([], :node_name => "foo")
        api.node_name.should == "foo"
      end
    end

    context "when the object is nil and node_name was passed" do
      it "returns the passed in node name" do
        api = ActiveApi::Base.new(nil, :node_name => "foo")
        api.node_name.should == "foo"
      end
    end

    context "when the array is not empty and node_name was passed" do
      it "returns the passed in node name" do
        api = ActiveApi::Base.new([@some_object], :node_name => "foo")
        api.node_name.should == "foo"
      end
    end

    context "when the object is not nil and node_name was passed" do
      it "returns the passed in node name" do
        api = ActiveApi::Base.new(@some_object, :node_name => "foo")
        api.node_name.should == "foo"
      end
    end
  end

end