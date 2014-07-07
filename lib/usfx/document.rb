require 'nokogiri'

module USFX

  # The Document class used by Nokogiri SAX Parser,
  # with an added "verse" event for convenience
  class Document < Nokogiri::XML::SAX::Document

    # list of book ids that should be skipped
    IGNORE_BOOK_IDS = %w(FRT)

    def initialize
      super
      @book_num = 0
    end

    # main dispatcher, calls other specific element event methods
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

    # dispatcher for closing tags
    def end_element(name)
      case name
      when 'book', 'c'
        end_verse if @mode == 'verse'
      when 'h'
        end_book_title
      when 'f', 'x'
        end_footnote
      end
    end

    # event fired when book is started
    def start_book(attributes)
      id = Hash[attributes]['id']
      unless IGNORE_BOOK_IDS.include?(id)
        @book_num += 1
        @book_id = id
        @mode = 'book'
        @book = ''
      end
    end

    # event fired when book title is started
    def start_book_title(attributes)
      @mode = 'book-title' if @mode == 'book'
    end

    # event fired when book title is ended
    def end_book_title
      @mode = nil
    end

    # event fired when chapter is started
    def start_chapter(attributes)
      @chapter = Hash[attributes]['id'].to_i
    end

    # event fired when verse is started
    def start_verse(attributes)
      @verse = Hash[attributes]['id'].to_i
      @text = ''
      @mode = 'verse'
    end

    # event fired when verse is ended
    def end_verse
      @mode = nil
      verse(book_num: @book_num, book_id: @book_id, book: @book, chapter: @chapter, verse: @verse, text: @text)
    end

    # event fired when footnote is started
    def start_footnote(attributes)
      @mode = "footnote|#{@mode}"
    end

    # event fired when footnote is ended
    def end_footnote
      @mode = @mode.split('|').last
    end

    # event fired when encountering text data in a tag
    def characters(string)
      case @mode
      when 'book-title'
        @book << string unless string == "\n"
      when 'verse'
        @text << string
      end
    end

    # event fired upon completion of a verse
    # verse data is passed as a hash of the form:
    #
    #   {
    #     book_num: 1,
    #     book_id: 'GEN',
    #     book: 'Genesis',
    #     chapter: 1,
    #     verse: 1,
    #     text: 'In the beginning, God created the heavens and the earth.'
    #   }
    #
    # By default, this event will print the raw verse data.
    # Override in your subclass to do fun stuff.
    def verse(data)
      p(data)
    end
  end
end
