require 'nokogiri'

class BibleParser
  module Parsers
    module Base
      class Document < Nokogiri::XML::SAX::Document
        def initialize(io:, iterator: :verse, iterate_book_id: nil, iterate_chapter_num: nil, &block)
          super()
          @book_num = 0
          @io = io
          @iterator = iterator
          @iterate_book_id = iterate_book_id
          @iterate_chapter_num = iterate_chapter_num
          @block = block
        end

        def end_book
          return unless @book_title
          return unless @iterator == :book
          @block.call(
            num: @book_num,
            id: @book_id,
            title: @book_title
          )
        end

        def end_chapter
          return unless @chapter
          return unless @iterator == :chapter
          return if @iterate_book_id && @iterate_book_id != @book_id
          @block.call(
            num: @chapter,
            book_id: @book_id,
            book_num: @book_num,
            book_title: @book_title
          )
        end

        def end_verse
          @mode = nil
          return unless @iterator == :verse
          return if @iterate_book_id && @iterate_book_id != @book_id
          return if @iterate_chapter_num && @iterate_chapter_num != @chapter
          @block.call(
            num: @verse,
            book_id: @book_id,
            book_num: @book_num,
            book_title: @book_title,
            chapter_num: @chapter,
            text: @text
          )
        end
      end
    end
  end
end
