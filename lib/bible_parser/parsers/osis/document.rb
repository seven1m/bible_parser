require_relative 'book_ids'

class BibleParser
  module Parsers
    module OSIS
      class Document < Base::Document
        include BookIDs

        def start_element(name, attributes)
          case name
          when 'div'
            end_verse if @mode == 'verse'
            start_book(attributes)
          when 'milestone'
            set_book_title_from_milestone(attributes)
          when 'title'
            set_book_title(attributes)
          when 'chapter'
            end_verse if @mode == 'verse'
            start_chapter(attributes)
          when 'verse'
            end_verse if @mode == 'verse'
            start_verse(attributes)
          when 'note'
            start_footnote(attributes)
          end
        end

        def end_element(name)
          case name
          when 'div'
            if @book_id
              end_book
              @book_id = nil
            end
          when 'verse'
            end_verse if @mode == 'verse' && @wrapping_verse
          when 'chapter'
            end_chapter if @wrapping_chapter
          when 'note'
            @mode = 'verse'
          end
        end

        def start_book(attributes)
          attributes = Hash[attributes]
          return unless attributes['type'] == 'book'
          id = attributes['osisID']
          @book_num += 1
          @book_id = BOOK_IDS[id] || id.upcase[0..2]
          @mode = 'book'
          @book_title = id
        end

        def set_book_title(attributes)
          attributes = Hash[attributes]
          return unless attributes['type'] == 'main'
          @book_title = attributes['short']
        end

        def set_book_title_from_milestone(attributes)
          attributes = Hash[attributes]
          @book_title = attributes['n']
        end

        def end_book_title
          @mode = nil
        end

        def start_chapter(attributes)
          attributes = Hash[attributes]
          if attributes['sID']
            @chapter = attributes['n'].to_i
            @wrapping_chapter = false
          elsif attributes['osisID']
            @chapter = attributes['osisID'].split('.').last.to_i
            @wrapping_chapter = true
          else
            end_chapter
          end
        end

        def start_verse(attributes)
          attributes = Hash[attributes]
          if attributes['sID']
            @verse = attributes['n'].to_i
            @wrapping_verse = false
          elsif attributes['osisID']
            @verse = attributes['osisID'].split('.').last.to_i
            @wrapping_verse = true
          else
            return
          end
          @text = ''
          @mode = 'verse'
        end

        # Properly parse footnotes out of the text that shows up within a verse
        def start_footnote(attributes)
          @mode = 'note'
        end

        def end_footnote(attributes)
          @mode = 'verse'
        end

        def characters(string)
          case @mode
          when 'verse'
            @text << string
          end
        end
      end
    end
  end
end
