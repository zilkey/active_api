require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module ActiveApi
  describe Field do
    it "has a type" do
      definition = Field.new :type => :string
      definition.type.should == :string
    end

    it "has a name" do
      definition = Field.new :name => :title
      definition.name.should == :title
    end
  end
end