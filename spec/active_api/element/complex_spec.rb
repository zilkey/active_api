require 'spec/spec_helper'

module ActiveApi
  describe Element::Complex do

    before do
      @article = Article.new
      @article.id = 1
      @article.title = "Some title"

      @schema = Schema.version(:v1) do |xsl|
        xsl.define :article do |t|
          t.string :title
        end
      end
    end

    describe "with a definition with fields" do
      it "emits the node and all fields within the node" do
        element = Element::Complex.new @article, :node => :article, :schema => @schema
        doc = element.build_xml.doc
        doc.xpath("/article/title").first.inner_text.should == @article.title
      end
    end

  end
end
