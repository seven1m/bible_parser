require_relative 'bible_parser/parsers'
require_relative 'bible_parser/errors'
require_relative 'bible_parser/book'
require_relative 'bible_parser/chapter'
require_relative 'bible_parser/verse'

require 'stringio'

class BibleParser
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

  def each_book(&block)
    @io.rewind
    if block
      parser.each_book(&block)
    else
      parser.enum_for(:each_book)
    end
  end

  def books
    each_book.to_a
  end

  def each_verse(&block)
    @io.rewind
    if block
      parser.each_verse(&block)
    else
      parser.enum_for(:each_verse)
    end
  end

  def verses
    each_verse.to_a
  end

  private

  def parser
    parser_class.new(@io)
  end

  def parser_class
    PARSERS[format] or fail(Errors::ParserUnavailableError, "Parser for #{format.inspect} could not be loaded.")
  end

  def detect_format
    PARSERS.each do |name, parser|
      @io.rewind
      return name if parser.new(@io).valid?
    end
  end
end
