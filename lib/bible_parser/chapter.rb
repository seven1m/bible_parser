class BibleParser
  class Chapter
    attr_reader :num, :book_id, :book_num, :book_title

    def initialize(num:, book_id:, book_num:, book_title:, parser:)
      @num = num
      @book_id = book_id
      @book_num = book_num
      @book_title = book_title
      @parser = parser
    end

    def each_verse(&block)
      if block
        @parser.each_verse(book_id: book_id, chapter_num: num, &block)
      else
        enum_for(:each_verse)
      end
    end

    def verses
      each_verse.to_a
    end

    def book
      Book.new(
        id: book_id,
        num: book_num,
        title: book_title,
        parser: @parser
      )
    end

    def ==(other)
      book_id == other.book_id && num == other.num
    end

    def inspect
      "<#{to_s}>"
    end

    def to_s
      "#{book_title} #{num}"
    end

    def to_h
      {
        num:         num,
        book_id:     book_id,
        book_num:    book_num,
        book_title:  book_title
      }
    end
  end
end
