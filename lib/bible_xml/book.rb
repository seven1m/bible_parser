class BibleXML
  class Book
    attr_reader :num, :id, :title

    def initialize(num:, id:, title:, parser:)
      @num = num
      @id = id
      @title = title
      @parser = parser
    end

    def each_chapter(&block)
      @parser.each_chapter(book_id: id, &block)
    end

    def chapters
      enum_for(:each_chapter)
    end

    def ==(other_book)
      id == other_book.id
    end

    def inspect
      "<#{title}>"
    end
  end
end
