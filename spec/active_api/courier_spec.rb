require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module ActiveApi
  describe Courier do

    before do
      @some_object = SomeData.new
      @some_object.id = 1
      @some_object.name = "some name"
    end

    describe "#ancestors" do
      it "is an empty array by default" do
        Courier.new.ancestors.should be_empty
      end

      it "adds the parent passed in" do
        Courier.new(:parent => "foo").ancestors.should == ["foo"]
      end
    end

  end
end
