require 'spec/spec_helper'

module ActiveApi
  describe Definition do

    describe "#class_symbol" do
      it "returns what is passed in" do
        Definition.new(:definition_name => :article).definition_name.should == :article
      end
    end

    describe "#fields" do
      it "is empty by default" do
        Definition.new(:definition_name => :article).fields.should be_empty
      end
    end

    [:string, :has_many, :belongs_to, :has_one].each do |method_name|
      describe "##{method_name}" do
        it "adds a #{method_name} field with the options" do
          definition = Definition.new(:definition_name => :article)
          definition.send method_name, :title
          definition.fields.length.should == 1
          definition.fields.first.type.should == method_name
          definition.fields.first.name.should == :title
        end
      end
    end
    
  end
end