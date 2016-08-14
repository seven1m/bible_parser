require_relative 'book_ids'

class BibleParser
  module Parsers
    module ZXBML
      class Document < Base::Document
        include BookIDs

        def start_element(name, attributes)
          case name
          when 'BIBLEBOOK'
            start_book(attributes)
          when 'CHAPTER'
            start_chapter(attributes)
          when 'VERS'
            start_verse(attributes)
          end
        end

        def end_element(name)
          case name
          when 'BIBLEBOOK'
            end_book
            end_verse if @mode == 'verse'
          when 'CHAPTER'
            end_chapter
            end_verse if @mode == 'verse'
          when 'VERS'
            end_verse
          end
        end

        def start_book(attributes)
          bnumber = Hash[attributes]['bnumber'].to_i
          @book_num += 1
          @book_id = BOOK_IDS[bnumber]
          @mode = 'book'
          @book_title = Hash[attributes]['bname']
        end

        def start_chapter(attributes)
          @chapter = Hash[attributes]['cnumber'].to_i
        end

        def start_verse(attributes)
          @verse = Hash[attributes]['vnumber'].to_i
          @text = ''
          @mode = 'verse'
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
