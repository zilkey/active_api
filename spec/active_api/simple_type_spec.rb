require 'spec/spec_helper'

module ActiveApi
  describe SimpleType do

    it "builds the node with the value" do
      element = SimpleType.new "foo", :node => :bar
      doc = element.build_xml.doc
      doc.xpath("/bar").first.inner_text.should == "foo"
    end

  end
end