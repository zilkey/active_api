require 'spec/spec_helper'

module ActiveApi
  describe "Defining a schema" do

    describe "with an element of type string" do
      before do
        Schema.define :article do |t|
          t.element :id, :string
        end
        @article = Article.new :id => 456
      end

      it "emits the string element" do
        element = Element::Collection.new [@article], :node => :article
        doc = element.build_xml.doc
        doc.xpath("/articles/article/id").inner_text.should == "456"
      end
    end

    describe "with a string" do
      before do
        Schema.define :article do |t|
          t.string   :title
        end
        @article = Article.new :title => Faker::Company.bs
      end

      it "emits the string element" do
        element = Element::Collection.new [@article], :node => :article
        doc = element.build_xml.doc
        doc.xpath("/articles/article/title").first.inner_text.should == @article.title
      end
    end

    describe "with an attribute of type string" do
      before do
        Schema.define :article do |t|
          t.attribute :id
        end
        @article = Article.new :id => 456
      end

      it "emits the string attribute" do
        element = Element::Collection.new [@article], :node => :article
        doc = element.build_xml.doc
        doc.xpath("/articles/article[@id=456]").should be
      end
    end

    describe "with a has_many element" do
      before do
        Schema.define :article do |t|
          t.has_many :comments
        end

        @article = Article.new :title => Faker::Company.bs
        @comment = Comment.new :article => @article, :text => Faker::Company.bs
        @article.comments = [@comment]
      end

      it "emits each of the child objects" do
        Schema.define :comment do |t|
          t.string :text
        end

        element = Element::Collection.new [@article], :node => :article
        doc = element.build_xml.doc
        doc.xpath("/articles/article/comments/comment/text").first.inner_text.should == @comment.text
      end
    end

    describe "with custom value procs" do
      before do
        class Schema
          define :article do |t|
            t.has_many :comments
          end

          define :comment do |t|
            t.string      :article_title, :value => proc{|comment| comment.object.article.title }
            t.belongs_to  :user
          end

          define :user do |t|
            t.string :title, :value => proc{|author| author.parents[:article].title }
          end
        end

        @article1 = Article.new :title => Faker::Company.bs
        @article2 = Article.new :title => Faker::Lorem.sentence

        @user = User.new
        @comment1 = Comment.new :article => @article1, :user => @user
        @comment2 = Comment.new :article => @article2, :user => @user

        @article1.comments = [@comment1]
        @article2.comments = [@comment2]
      end

      it "emits the value of the value proc, which is passed an element containing a reference to the object" do
        element = Element::Collection.new [@article1], :node => :article
        doc = element.build_xml.doc
        doc.xpath("/articles/article/comments/comment/article_title").first.inner_text.should == @article1.title
      end

      it "emits the value of the value proc, which is passed an element containing a reference all ancestor objects" do
        element = Element::Collection.new [@article1, @article2], :node => :article
        doc = element.build_xml.doc
        doc.xpath("/articles/article").length.should == 2
        doc.xpath("/articles/article/comments/comment/user/title").first.inner_text.should == @article1.title
        doc.xpath("/articles/article/comments/comment/user/title").last.inner_text.should == @article2.title
      end
    end

    describe "with belongs_to elements marked as polymorphic" do
      before do
        class Schema
          define :article do |t|
            t.string :title
          end

          define :user do |t|
            t.string :username
          end

          define :comment do |t|
            t.belongs_to :commentable, :polymorphic => {
              "Article" => :article,
              "User" => :user
            }
          end
        end

        @article = Article.new :title => Faker::Company.bs
        @user = User.new :username => Faker::Internet.user_name
        @comment1 = Comment.new :commentable => @article
        @comment2 = Comment.new :commentable => @user
        @comment3 = Comment.new :commentable => nil
      end

      it "uses the name of the class to lookup the definition to be used" do
        element = Element::Collection.new [@comment1, @comment2, @comment3], :node => :comment
        doc = element.build_xml.doc
        doc.xpath("/comments/comment").length.should == 3
        doc.xpath("/comments/comment/article/title").inner_text.should == @article.title
        doc.xpath("/comments/comment/user/username").inner_text.should == @user.username
        doc.xpath("/comments/comment")[2].inner_text.should be_empty
      end
    end

  end
end

