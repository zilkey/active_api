require 'spec/spec_helper'

module ActiveApi
  describe Element::Simple do

    it "builds the node with the value" do
      element = Element::Simple.new "foo", :node => :bar
      doc = element.build_xml.doc
      doc.xpath("/bar").first.inner_text.should == "foo"
    end

  end
end