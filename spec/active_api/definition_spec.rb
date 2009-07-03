require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module ActiveApi
  describe Definition do

    describe "#class_symbol" do
      it "returns what is passed in" do
        Definition.new(:article).class_symbol.should == :article
      end
    end

    describe "#fields" do
      it "is empty by default" do
        Definition.new(:article).fields.should be_empty
      end
    end

  end
end