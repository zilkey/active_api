module ActiveApi
  module Builder

    def build_xml(builder = Nokogiri::XML::Builder.new)
      builder.tap do |xml|
        build(xml)
      end
    end

  end
end