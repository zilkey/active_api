require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module ActiveApi
  describe Courier do

    before do
      @article = Article.new
      @article.id = 1
      @article.title = "some name"
    end

    describe "#ancestors" do
      it "is an empty array by default" do
        Courier.new.ancestors.should be_empty
      end

      it "adds the parent passed in" do
        Courier.new(:parent => @article).ancestors.should == [@article]
      end
    end

  end
end
