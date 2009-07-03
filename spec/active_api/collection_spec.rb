require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ActiveApi::Element do

  before do
    @some_object = SomeData.new
    @some_object.id = 1
    @some_object.name = "some name"
  end

  describe ".new" do
    it "should return a nil object when nil" do
      api = ActiveApi::Collection.new([])
      api.objects.should be_empty
    end

    it "should return the object when not nil" do
      api = ActiveApi::Collection.new([@some_object])
      api.objects.should == [@some_object]
    end
  end

end