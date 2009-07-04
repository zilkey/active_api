require 'spec/spec_helper'

module ActiveApi
  describe Elements::Base do

    before do
      @article = Article.new
      @article.id = 1
      @article.title = "Some title"
    end

    describe ".new" do
      it "sets options" do
        api = Elements::Base.new(nil, :foo => :bar)
        api.options.should == {:foo => :bar}
      end
    end

    describe "#objects" do
      context "when passed an array" do
        it "should return an empty array when passed an empty array" do
          api = Elements::Base.new([])
          api.objects.should be_empty
        end

        it "should return the array when given a non-empty array" do
          api = Elements::Base.new([@article])
          api.objects.should == [@article]
        end
      end

      context "when passed an element" do
        it "should return an empty array when passed nil" do
          api = Elements::Base.new(nil)
          api.objects.should be_empty
        end

        it "should return an array of the object when given an object" do
          api = Elements::Base.new(@article)
          api.objects.should == [@article]
        end
      end
    end

    describe "#object" do
      context "when passed an array" do
        it "should return nil when passed an empty array" do
          api = Elements::Base.new([])
          api.object.should be_nil
        end

        it "should return the first object in the array when given a non-empty array" do
          @article2 = Article.new
          @article2.id = 2
          api = Elements::Base.new([@article, @article2])
          api.object.should == @article
        end
      end

      context "when passed an object" do
        it "should return nil when passed nil" do
          api = Elements::Base.new(nil)
          api.object.should be_nil
        end

        it "should return the object when given an object" do
          api = Elements::Base.new(@article)
          api.object.should == @article
        end
      end
    end

    describe "#fields" do
      context "when passed nothing" do
        it "returns an empty array" do
          api = Elements::Base.new(@article)
          api.fields.should == []
        end
      end

      context "when passed nil" do
        it "returns an empty array" do
          api = Elements::Base.new(@article, :fields => nil)
          api.fields.should == []
        end
      end

      context "when passed a single field" do
        it "returns an array of the field" do
          field = Field.new
          api = Elements::Base.new(@article, :fields => field)
          api.fields.should == [field]
        end
      end

      context "when passed an array of fields" do
        it "returns the array" do
          field = Field.new
          api = Elements::Base.new(@article, :fields => field)
          api.fields.should == [field]
        end
      end
    end

    describe "#node_name" do
      context "when the array is empty, and the node_name is not passed" do
        it "returns nil" do
          api = Elements::Base.new([])
          api.node_name.should be_nil
        end
      end

      context "when the object is nil, and the node_name is not passed" do
        it "returns nil" do
          api = Elements::Base.new(nil)
          api.node_name.should be_nil
        end
      end

      context "when the array is not empty, and the node name is not passed" do
        it "returns the name of the first object in the array" do
          api = Elements::Base.new([@article])
          api.node_name.should == "article"
        end
      end

      context "when the object is not nil" do
        it "returns the name of the object" do
          api = Elements::Base.new(@article)
          api.node_name.should == "article"
        end
      end

      context "when the array is empty and node_name was passed" do
        it "returns the passed in node name" do
          api = Elements::Base.new([], :node_name => "foo")
          api.node_name.should == "foo"
        end
      end

      context "when the object is nil and node_name was passed" do
        it "returns the passed in node name" do
          api = Elements::Base.new(nil, :node_name => "foo")
          api.node_name.should == "foo"
        end
      end

      context "when the array is not empty and node_name was passed" do
        it "returns the passed in node name" do
          api = Elements::Base.new([@article], :node_name => "foo")
          api.node_name.should == "foo"
        end
      end

      context "when the object is not nil and node_name was passed" do
        it "returns the passed in node name" do
          api = Elements::Base.new(@article, :node_name => "foo")
          api.node_name.should == "foo"
        end
      end
    end

    describe "#courier" do
      it "is a Courier object" do
        api = Elements::Base.new(@article, :parent => "foo")
        api.courier.should be_kind_of(ActiveApi::Courier)
      end

      it "sets the options correctly" do
        api = Elements::Base.new(@article, :parent => "foo", :node_name => "bar")
        api.courier.ancestors.should == ["foo"]
        api.courier.node_name.should == "bar"
      end
    end

    describe "#parent" do
      context "when passed a parent option" do
        api = Elements::Base.new(@article, :parent => "foo")
        api.parent.should == "foo"
      end
    end

    describe "#content" do
      context "when passed field" do
        it "returns the value of the field on the object" do
          @article.title = Faker::Company.bs
          node = Elements::Base.new @article, :field => :title
          node.content.should == @article.title
        end
      end

      context "when passed a value" do
        it "returns the value passed" do
          node = Elements::Base.new @article, :value => "foo"
          node.content.should == "foo"
        end
      end

      context "when passed a value and a field" do
        it "returns the value passed" do
          node = Elements::Base.new @article, :value => "foo", :field => :title
          node.content.should == "foo"
        end
      end

      context "when passed neither a field nor a value" do
        it "raises an error" do
          node = Elements::Base.new @article
          proc {
            node.content
          }.should raise_error("You must specify either :field or :value")
        end
      end
    end

    describe "#should_build?" do
      it "returns false if the object is nil" do
        node = Elements::Base.new nil
        node.should_build?.should be_false
      end

      it "returns true if the object is there and no options are set" do
        node = Elements::Base.new @article
        node.should_build?.should be_true
      end

      context "when build_empty_nodes is false" do
        it "returns false if content is blank" do
          node = Elements::Base.new @article, :build_empty_nodes => false
          mock(node).content { nil }
          node.should_build?.should be_false
        end

        it "returns true if content is not blank" do
          node = Elements::Base.new @article, :build_empty_nodes => false
          mock(node).content { "foo" }
          node.should_build?.should be_true
        end
      end

      context "when build_empty_nodes is true" do
        it "returns true if content is blank" do
          node = Elements::Base.new @article, :build_empty_nodes => true
          node.should_build?.should be_true
        end

        it "returns true if content is not blank" do
          node = Elements::Base.new @article, :build_empty_nodes => true
          node.should_build?.should be_true
        end
      end

      context "when passed an if block that corresponds to a method on the object" do
        it "returns false if the method on the object returns false" do
          def @article.published?()
            false
          end
          node = Elements::Base.new @article, :if => :published?
          node.should_build?.should be_false
        end

        it "returns true if the method on the object returns true" do
          def @article.published?()
            true
          end
          node = Elements::Base.new @article, :if => :published?
          node.should_build?.should be_true
        end
      end

      context "when passed an unless block that corresponds to a method on the object" do
        it "returns true if the method on the object returns false" do
          def @article.published?()
            false
          end
          node = Elements::Base.new @article, :unless => :published?
          node.should_build?.should be_true
        end

        it "returns false if the method on the object returns true" do
          def @article.published?()
            true
          end
          node = Elements::Base.new @article, :unless => :published?
          node.should_build?.should be_false
        end
      end

      context "when passed if and unless symbols" do
        it "returns true if both conditions are met" do
          def @article.published?()
            true
          end
          def @article.current?()
            false
          end
          node = Elements::Base.new @article, :if => :published?, :unless => :current?
          node.should_build?.should be_true
        end

        it "returns false if the if is unmet" do
          def @article.published?()
            false
          end
          def @article.current?()
            false
          end
          node = Elements::Base.new @article, :if => :published?, :unless => :current?
          node.should_build?.should be_false
        end

        it "returns false if the unless is unmet" do
          def @article.published?()
            true
          end
          def @article.current?()
            true
          end
          node = Elements::Base.new @article, :if => :published?, :unless => :current?
          node.should_build?.should be_false
        end
      end

      context "when build_empty_nodes is false, and content is empty, and ifs are true" do
        it "returns false" do
          def @article.published?()
            true
          end
          node = Elements::Base.new @article, :build_empty_nodes => false, :if => :published?
          mock(node).content { nil }
          node.should_build?.should be_false
        end
      end

    end

    describe "#build_xml" do
      before do
        @article = Article.new
        @article.title = Faker::Company.bs
      end

      it "returns a builder object" do
        api = Elements::Base.new(@article)
        api.build_xml.should be_kind_of(Nokogiri::XML::Builder)
      end

      it "adds the doctype" do
        field = Field.new :type => :string, :name => :title
        api = Elements::Base.new(@article, :fields => [field])
        doc = api.build_xml.doc
        doc.to_s.should include(%Q|<?xml version="1.0"?>|)
      end

      it "builds all of the fields given" do
        field = Field.new :type => :string, :name => :title
        api = Elements::Base.new(@article, :fields => [field])
        doc = api.build_xml.doc
        doc.xpath("/article/title").inner_text.should == @article.title
      end
    end

  end
end
