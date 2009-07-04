require 'spec/spec_helper'

module ActiveApi
  describe Element::Collection do

    before do
      class Schema
        define :article do |t|
          t.string   :title
          t.has_many :comments
        end

        define :comment do |t|
          t.string      :title, :value => proc{|comment|
            comment.object.article.title
          }
          t.belongs_to  :user
        end

        define :user do |t|
          t.string      :title, :value => proc{|author|
            author.parents[:article].title
          }
        end
      end

      @article = Article.new
      @article.id = 1
      @article.title = "Some title"
      user = User.new
      comment = Comment.new
      comment.article = @article
      comment.user = user
      @article.comments = [comment]
    end

    after do
      Schema.definitions = []
    end

    describe "with an array" do
      it "works" do
        element = Element::Collection.new [@article], :node => :article
        doc = element.build_xml.doc
        doc.xpath("/articles/article/title").first.inner_text.should == @article.title
      end
    end

    it "stores a reference to the parents" do
      element = Element::Collection.new [@article], :node => :article
      doc = element.build_xml.doc
      doc.xpath("/articles/article/comments/comment/title").first.inner_text.should == @article.title
    end

    it "stores a reference to the node ancestors" do
      element = Element::Collection.new [@article], :node => :article
      doc = element.build_xml.doc
      doc.xpath("/articles/article/comments/comment/user/title").first.inner_text.should == @article.title
    end
  end
end

