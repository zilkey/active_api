require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module ActiveApi
  describe Schema do

    describe ".define" do
      describe "with a single string field named bar" do
        before do
          Schema.define :some_data do |t|
            t.string :name
          end
        end

        it "adds one definition of type string" do
          Schema.definitions.length.should == 1
          definition = Schema.definitions.first
          definition.should be_kind_of(Definition)
          definition.class_symbol.should == :some_data
        end

        it "sets the fields on the definition correctly" do
          definition = Schema.definitions.first
          definition.fields.length.should == 1
          field = definition.fields.first
          field.type.should == :string
          field.name.should == :name
        end
      end
    end

  end
end