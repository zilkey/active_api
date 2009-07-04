require 'spec/spec_helper'

module ActiveApi
  describe Element::Complex do

    before do
      @article = Article.new
      @article.id = 1
      @article.title = "Some title"

      @definition = Definition.new :node_name => :article
      @definition.string    :title
      @definition.parent    :author
      @definition.children  :comments
    end

    describe "with a definition with fields" do
      it "emits the node and all fields within the node" do
        element = Element::Complex.new @article, :definition => @definition
        doc = element.build_xml.doc
        puts doc.to_xml
        doc.xpath("/article/title").first.inner_text.should == @article.title
      end
    end

  end
end
