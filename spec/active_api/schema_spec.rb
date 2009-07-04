require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module ActiveApi
  describe Schema do

    before do
      Schema.reset_inheritable_attributes
      Schema.definitions = []
      class Schema
        define :article do |t|
          t.string :title
          t.has_many :comments
        end
      end
    end

    after do
      Schema.reset_inheritable_attributes
      Schema.definitions = []
    end

    describe ".define" do
      describe "with a single field" do

        it "adds one definition of the correct type" do
          Schema.definitions.length.should == 1
          definition = Schema.definitions.first
          definition.should be_kind_of(Definition)
          definition.name.should == :article
        end

        it "sets the fields on the definition correctly" do
          definition = Schema.definitions.first
          definition.fields.length.should == 2
          field = definition.fields.first
          field.type.should == :string
          field.name.should == :title
        end
      end

      describe "with a multiple fields" do

        it "adds one definition of the correct type article" do
          Schema.definitions.length.should == 1
          definition = Schema.definitions.first
          definition.should be_kind_of(Definition)
          definition.name.should == :article
        end

        it "sets the fields on the definition correctly" do
          definition = Schema.definitions.first
          definition.fields.length.should == 2
          field1 = definition.fields.first
          field1.type.should == :string
          field1.name.should == :title
          field2 = definition.fields.last
          field2.type.should == :has_many
          field2.name.should == :comments
        end
      end
    end
    
  end
end