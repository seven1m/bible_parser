require 'nokogiri'

class BibleParser
  module Parsers
    module Base
      class Parser
        def initialize(io)
          @io = io
        end

        def valid?
          fail NotImplementedError, "override #valid? in your Parser class"
        end

        def document_class
          module_name = self.class.name.sub(/::Parser$/, '')
          Kernel.const_get("#{module_name}::Document")
        end

        def each_book
          @io.rewind
          document = document_class.new(io: @io, iterator: :book) do |book|
            yield Book.new(
              num: book[:num],
              id: book[:id],
              title: book[:title],
              parser: self
            )
          end
          sax_parser = Nokogiri::XML::SAX::Parser.new(document)
          sax_parser.parse(@io)
        end

        def each_chapter(book_id: nil, &block)
          @io.rewind
          document = document_class.new(io: @io, iterator: :chapter, iterate_book_id: book_id) do |chapter|
            yield Chapter.new(
              num: chapter[:num],
              book_id: chapter[:book_id],
              book_num: chapter[:book_num],
              book_title: chapter[:book_title],
              parser: self
            )
          end
          sax_parser = Nokogiri::XML::SAX::Parser.new(document)
          sax_parser.parse(@io)
        end

        def each_verse(book_id: nil, chapter_num: nil, &block)
          @io.rewind
          document = document_class.new(io: @io, iterator: :verse, iterate_book_id: book_id, iterate_chapter_num: chapter_num) do |verse|
            yield Verse.new(
              num: verse[:num],
              text: verse[:text],
              book_id: verse[:book_id],
              book_num: verse[:book_num],
              book_title: verse[:book_title],
              chapter_num: verse[:chapter_num],
              parser: self
            )
          end
          sax_parser = Nokogiri::XML::SAX::Parser.new(document)
          sax_parser.parse(@io)
        end
      end
    end
  end
end
