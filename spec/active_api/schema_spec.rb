require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module ActiveApi
  describe Schema do

    after do
      Schema.reset_inheritable_attributes
    end

    describe ".define" do
      describe "with a single string field" do
        before do
          class Schema
            define :article do |t|
              t.string :title
            end
          end
        end

        it "adds one definition of type article" do
          Schema.definitions.length.should == 1
          definition = Schema.definitions.first
          definition.should be_kind_of(Definition)
          definition.class_symbol.should == :article
        end

        it "sets the fields on the definition correctly" do
          definition = Schema.definitions.first
          definition.fields.length.should == 1
          field = definition.fields.first
          field.type.should == :string
          field.name.should == :title
        end
      end

      describe "with a multiple string fields" do
        before do
          class Schema
            define :article do |t|
              t.string :title
              t.string :author_id
            end
          end
        end

        it "adds one definition of type article" do
          Schema.definitions.length.should == 1
          definition = Schema.definitions.first
          definition.should be_kind_of(Definition)
          definition.class_symbol.should == :article
        end

        it "sets the fields on the definition correctly" do
          definition = Schema.definitions.first
          definition.fields.length.should == 2
          field1 = definition.fields.first
          field1.type.should == :string
          field1.name.should == :title
          field2 = definition.fields.last
          field2.type.should == :string
          field2.name.should == :author_id
        end
      end

    end

  end
end