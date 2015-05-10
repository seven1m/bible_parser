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
      if block
        @parser.each_chapter(book_id: id, &block)
      else
        enum_for(:each_chapter)
      end
    end

    def chapters
      each_chapter.to_a
    end

    def ==(other)
      id == other.id
    end

    def inspect
      "<#{title}>"
    end

    def to_h
      {
        num:   num,
        id:    id,
        title: title
      }
    end
  end
end
