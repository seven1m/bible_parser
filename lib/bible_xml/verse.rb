class BibleParser
  class Verse
    attr_reader :num, :book_id, :book_num, :book_title, :chapter_num, :text

    def initialize(num:, book_id:, book_num:, book_title:, chapter_num:, text:, parser:)
      @num = num
      @book_id = book_id
      @book_num = book_num
      @book_title = book_title
      @chapter_num = chapter_num
      @text = text
      @parser = parser
    end

    def inspect
      "<#{to_s}>"
    end

    def to_s
      "#{book_title} #{chapter_num}:#{num}"
    end


    def book
      Book.new(
        id: book_id,
        num: book_num,
        title: book_title,
        parser: @parser
      )
    end

    def chapter
      Chapter.new(
        book_id: book_id,
        book_num: book_num,
        book_title: book_title,
        num: chapter_num,
        parser: @parser
      )
    end

    def to_h
      {
        num:         num,
        book_id:     book_id,
        book_num:    book_num,
        book_title:  book_title,
        chapter_num: chapter_num,
        text:        text
      }
    end
  end
end
