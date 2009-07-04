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

      @article1 = Article.new :title => Faker::Company.bs
      @article2 = Article.new :title => Faker::Company.bs

      @user = User.new
      @comment1 = Comment.new :article => @article1, :user => @user
      @comment2 = Comment.new :article => @article2, :user => @user

      @article1.comments = [@comment1]
      @article2.comments = [@comment2]
    end

    after do
      Schema.definitions = []
    end

    describe "with an array" do
      it "works" do
        element = Element::Collection.new [@article1], :node => :article
        doc = element.build_xml.doc
        doc.xpath("/articles/article/title").first.inner_text.should == @article1.title
      end
    end

    it "stores a reference to the parents" do
      element = Element::Collection.new [@article1], :node => :article
      doc = element.build_xml.doc
      doc.xpath("/articles/article/comments/comment/title").first.inner_text.should == @article1.title
    end

    it "stores a reference to the node ancestors" do
      element = Element::Collection.new [@article1, @article2], :node => :article
      doc = element.build_xml.doc
      doc.xpath("/articles/article").length.should == 2
      doc.xpath("/articles/article/comments/comment/user/title").first.inner_text.should == @article1.title
      doc.xpath("/articles/article/comments/comment/user/title").last.inner_text.should == @article2.title
    end
  end
end

