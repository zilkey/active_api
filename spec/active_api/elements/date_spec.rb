require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

module ActiveApi

  describe Elements::Date do

    before do
      @article = Article.new
    end

    describe "#content" do
      context "when passed field with a value" do
        it "returns the value of the field on the object, formatted according to xml" do
          date = Date.parse("2008-5-5")
          @article.published_on = date
          node = Elements::Date.new @article, :field => :published_on
          node.content.should == date.xmlschema
        end
      end

      context "when passed field with no value" do
        it "returns the value of the field on the object, formatted according to xml" do
          node = Elements::Date.new @article, :field => :published_on
          node.content.should be_nil
        end
      end

      context "when passed a value" do
        it "returns the value passed" do
          node = Elements::Date.new @article, :value => "foo"
          node.content.should == "foo"
        end
      end

      context "when passed a value and a field" do
        it "returns the value passed" do
          node = Elements::Date.new @article, :value => "foo", :field => :title
          node.content.should == "foo"
        end
      end

      context "when passed neither a field nor a value" do
        it "raises an error" do
          node = Elements::Date.new @article
          proc {
            node.content
          }.should raise_error("You must specify either :field or :value")
        end
      end
    end

  end
end