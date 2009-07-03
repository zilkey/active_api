require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

module ActiveApi::Elements
  describe Collection do

    before do
      @article = Article.new
      @article.id = 1
      @article.title = "some name"
    end

  end
end
