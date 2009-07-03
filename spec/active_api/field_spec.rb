require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module ActiveApi
  describe Field do
    it "has a type" do
      definition = Field.new :type => "foo"
      definition.type.should == "foo"
    end

    it "has a name" do
      definition = Field.new :name => "foo"
      definition.name.should == "foo"
    end
  end
end