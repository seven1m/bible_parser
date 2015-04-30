require_relative 'bible_xml/parsers'
require_relative 'bible_xml/errors'
require_relative 'bible_xml/book'
require_relative 'bible_xml/chapter'
require_relative 'bible_xml/verse'

require 'stringio'

class BibleXML
  attr_reader :format

  def initialize(io, format: nil)
    if io.is_a?(String)
      @io = StringIO.new(io)
    elsif io.respond_to?(:read)
      @io = io
    else
      fail(
        Errors::UnknownIoObjectError,
        "#{io.inspect} is neither a File nor a String object. Please pass a File or a String."
      )
    end
    @format = format || detect_format
  end

  def books
    @io.rewind
    parser.enum_for(:each_book)
  end

  private

  def parser
    parser_class.new(@io)
  end

  def parser_class
    PARSERS[format] or fail(ParserUnavailableError, "Parser for #{format.inspect} could not be loaded.")
  end

  def detect_format
    @format = 'USFX'
  end
end
