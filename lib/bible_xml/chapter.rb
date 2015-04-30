class BibleXML
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
      @parser.each_verse(book_id: book_id, chapter_num: num, &block)
    end

    def verses
      enum_for(:each_verse)
    end

    def book
      Book.new(
        id: book_id,
        num: book_num,
        title: book_title,
        parser: @parser
      )
    end

    def ==(other_chapter)
      book_id == other_chapter.book_id && num == other_chapter.num
    end

    def inspect
      "<#{book_title} #{num}>"
    end
  end
end
