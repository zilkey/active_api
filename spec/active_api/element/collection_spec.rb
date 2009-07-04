require 'spec/spec_helper'

module ActiveApi
  describe Element::Collection do

    before do
      class Schema
        define :article do |t|
          t.string      :title
        end
      end

      @article = Article.new
      @article.id = 1
      @article.title = "Some title"
    end

    after do
      Schema.definitions = []
    end

    describe "with an array" do
      it "works" do
        element = Element::Collection.new [@article], :node => :article
        doc = element.build_xml.doc
      end
    end
  end
end

