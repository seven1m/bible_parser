require_relative '../../spec_helper'

describe BibleParser::Verse do
  let(:path)   { fixture_path('web.usfx.truncated.xml') }
  let(:file)   { File.open(path) }
  let(:parser) { BibleParser::Parsers::USFX::Parser.new(file) }

  subject do
    described_class.new(
      book_id: 'EXO',
      book_num: 2,
      book_title: 'Exodus',
      chapter_num: 2,
      num: 1,
      text: "A man of the house of Levi went and took a daughter of Levi as his wife.\n",
      parser: parser
    )
  end

  describe '#book_id' do
    it 'returns the book id' do
      expect(subject.book_id).to eq('EXO')
    end
  end

  describe '#chapter_num' do
    it 'returns the chapter num' do
      expect(subject.chapter_num).to eq(2)
    end
  end

  describe '#book' do
    it 'returns a book instance' do
      expect(subject.book).to eq(
        BibleParser::Book.new(
          id: 'EXO',
          num: 2,
          title: 'Exodus',
          parser: parser
        )
      )
    end
  end

  describe '#chapter' do
    it 'returns a chapter instance' do
      expect(subject.chapter).to eq(
        BibleParser::Chapter.new(
          book_id: 'EXO',
          book_num: 2,
          book_title: 'Exodus',
          num: 2,
          parser: parser
        )
      )
    end
  end
end
