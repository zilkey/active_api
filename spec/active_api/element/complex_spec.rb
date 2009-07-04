require 'spec/spec_helper'

module ActiveApi
  describe Element::Complex do

    before do
      @article = Article.new
      @article.id = 1
      @article.title = "Some title"

      Schema.reset_inheritable_attributes
      Schema.definitions = []
      class Schema
        define :article do |t|
          t.string :title
        end
      end
    end

    after do
      Schema.reset_inheritable_attributes
      Schema.definitions = []
    end
    
    describe "with a definition with fields" do
      it "emits the node and all fields within the node" do
        element = Element::Complex.new @article, :node => :article
        doc = element.build_xml.doc
        doc.xpath("/article/title").first.inner_text.should == @article.title
      end
    end

  end
end
