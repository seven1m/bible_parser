require 'nokogiri'

require_relative 'document'

module USFX

  # A tiny wrapper around Nokogiri::XML::SAX::Parser, just for fun.
  #
  # Usage:
  #
  #   parser = USFX::Parser.new
  #   parser.parse(File.open('eng-web_usfx.xml'))
  #
  # To use your own Document class:
  #
  #   class MyDocument < USFX::Document
  #     def verse(data)
  #       # do something with verse data here
  #     end
  #   end
  #
  #   parser = USFX::Parser.new(MyDocument.new)
  #   parser.parse(File.open('eng-web_usfx.xml'))
  #
  # (and with this example, USFX::Parser does absolutely nothing more than Nokogiri::XML::SAX::Parser)
  #
  class Parser < Nokogiri::XML::SAX::Parser
    def initialize(document=Document.new)
      super(document)
    end
  end

end
