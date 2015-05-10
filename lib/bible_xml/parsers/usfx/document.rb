require 'nokogiri'

class BibleParser
  module Parsers
    module USFX
      class Document < Base::Document
        # list of book ids that should be skipped
        IGNORE_BOOK_IDS = %w(FRT)

        def start_element(name, attributes)
          case name
          when 'book'
            start_book(attributes)
          when 'h'
            start_book_title(attributes)
          when 'c'
            start_chapter(attributes)
          when 'v'
            end_verse if @mode == 'verse'
            start_verse(attributes)
          when 've'
            end_verse
          when 'f', 'x'
            start_footnote(attributes)
          end
        end

        def end_element(name)
          case name
          when 'book'
            end_book
            end_verse if @mode == 'verse'
          when 'c'
            end_chapter
            end_verse if @mode == 'verse'
          when 'h'
            end_book_title
          when 'f', 'x'
            end_footnote
          end
        end

        def start_book(attributes)
          id = Hash[attributes]['id']
          return if IGNORE_BOOK_IDS.include?(id)
          @book_num += 1
          @book_id = id
          @mode = 'book'
          @book_title = ''
        end

        def start_book_title(_attributes)
          @mode = 'book-title' if @mode == 'book'
        end

        def end_book_title
          @book_title.strip! if @book_title
          @mode = nil
        end

        def start_chapter(attributes)
          @chapter = Hash[attributes]['id'].to_i
        end

        def start_verse(attributes)
          @verse = Hash[attributes]['id'].to_i
          @text = ''
          @mode = 'verse'
        end

        def start_footnote(_attributes)
          @mode = "footnote|#{@mode}"
        end

        def end_footnote
          @mode = @mode.split('|').last
        end

        def characters(string)
          case @mode
          when 'book-title'
            @book_title << string.gsub(/\n/, '')
          when 'verse'
            @text << string
          end
        end
      end
    end
  end
end
