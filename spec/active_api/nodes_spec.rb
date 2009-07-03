require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module ActiveApi

  describe Nodes::Base do

    before do
      @article = Article.new
    end

    it "takes an object" do
      node = Nodes::Base.new @article
      node.object.should == @article
    end

    describe "#content" do
      context "when passed field" do
        it "returns the value of the field on the object" do
          @article.title = Faker::Company.bs
          node = Nodes::Base.new @article, :field => :title
          node.content.should == @article.title
        end
      end

      context "when passed a value" do
        it "returns the value passed" do
          node = Nodes::Base.new @article, :value => "foo"
          node.content.should == "foo"
        end
      end

      context "when passed a value and a field" do
        it "returns the value passed" do
          node = Nodes::Base.new @article, :value => "foo", :field => :title
          node.content.should == "foo"
        end
      end

      context "when passed neither a field nor a value" do
        it "raises an error" do
          node = Nodes::Base.new @article
          proc {
            node.content
          }.should raise_error("You must specify either :field or :value")
        end
      end
    end

    describe "#should_build?" do
      it "returns false if the object is nil" do
        node = Nodes::Base.new nil
        node.should_build?.should be_false
      end

      it "returns true if the object is there and no options are set" do
        node = Nodes::Base.new @article
        node.should_build?.should be_true
      end

      context "when build_empty_nodes is false" do
        it "returns false if content is blank" do
          node = Nodes::Base.new @article, :build_empty_nodes => false
          mock(node).content { nil }
          node.should_build?.should be_false
        end

        it "returns true if content is not blank" do
          node = Nodes::Base.new @article, :build_empty_nodes => false
          mock(node).content { "foo" }
          node.should_build?.should be_true
        end
      end

      context "when build_empty_nodes is true" do
        it "returns true if content is blank" do
          node = Nodes::Base.new @article, :build_empty_nodes => true
          node.should_build?.should be_true
        end

        it "returns true if content is not blank" do
          node = Nodes::Base.new @article, :build_empty_nodes => true
          node.should_build?.should be_true
        end
      end

      context "when passed an if block that corresponds to a method on the object" do
        it "returns false if the method on the object returns false" do
          def @article.published?()
            false
          end
          node = Nodes::Base.new @article, :if => :published?
          node.should_build?.should be_false
        end

        it "returns true if the method on the object returns true" do
          def @article.published?()
            true
          end
          node = Nodes::Base.new @article, :if => :published?
          node.should_build?.should be_true
        end
      end

      context "when passed an unless block that corresponds to a method on the object" do
        it "returns true if the method on the object returns false" do
          def @article.published?()
            false
          end
          node = Nodes::Base.new @article, :unless => :published?
          node.should_build?.should be_true
        end

        it "returns false if the method on the object returns true" do
          def @article.published?()
            true
          end
          node = Nodes::Base.new @article, :unless => :published?
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
          node = Nodes::Base.new @article, :if => :published?, :unless => :current?
          node.should_build?.should be_true
        end

        it "returns false if the if is unmet" do
          def @article.published?()
            false
          end
          def @article.current?()
            false
          end
          node = Nodes::Base.new @article, :if => :published?, :unless => :current?
          node.should_build?.should be_false
        end

        it "returns false if the unless is unmet" do
          def @article.published?()
            true
          end
          def @article.current?()
            true
          end
          node = Nodes::Base.new @article, :if => :published?, :unless => :current?
          node.should_build?.should be_false
        end
      end

      context "when build_empty_nodes is false, and content is empty, and ifs are true" do
        it "returns false" do
          def @article.published?()
            true
          end
          node = Nodes::Base.new @article, :build_empty_nodes => false, :if => :published?
          mock(node).content { nil }
          node.should_build?.should be_false
        end
      end

    end
  end

  describe Nodes::Date do

    before do
      @article = Article.new
    end

    describe "#content" do
      context "when passed field with a value" do
        it "returns the value of the field on the object, formatted according to xml" do
          date = Date.parse("2008-5-5")
          @article.published_on = date
          node = Nodes::Date.new @article, :field => :published_on
          node.content.should == date.xmlschema
        end
      end

      context "when passed field with no value" do
        it "returns the value of the field on the object, formatted according to xml" do
          node = Nodes::Date.new @article, :field => :published_on
          node.content.should be_nil
        end
      end

      context "when passed a value" do
        it "returns the value passed" do
          node = Nodes::Base.new @article, :value => "foo"
          node.content.should == "foo"
        end
      end

      context "when passed a value and a field" do
        it "returns the value passed" do
          node = Nodes::Base.new @article, :value => "foo", :field => :title
          node.content.should == "foo"
        end
      end

      context "when passed neither a field nor a value" do
        it "raises an error" do
          node = Nodes::Base.new @article
          proc {
            node.content
          }.should raise_error("You must specify either :field or :value")
        end
      end
    end

  end
end