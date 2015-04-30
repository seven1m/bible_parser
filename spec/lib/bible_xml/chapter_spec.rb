require_relative '../../spec_helper'

describe BibleXML::Chapter do
  let(:path)   { File.join(tmp_path, 'web.usfx.xml') }
  let(:file)   { File.open(path) }
  let(:parser) { BibleXML::Parsers::USFX::Parser.new(file) }

  subject { described_class.new(book_id: 'EXO', book_num: 2, book_title: 'Exodus', num: 2, parser: parser) }

  describe '#book_id' do
    it 'returns the book id' do
      expect(subject.book_id).to eq('EXO')
    end
  end

  describe '#book' do
    it 'returns a book instance' do
      expect(subject.book).to eq(
        BibleXML::Book.new(
          id: 'EXO',
          num: 2,
          title: 'Exodus',
          parser: parser
        )
      )
    end
  end

  describe '#verses' do
    let(:verses) { subject.verses }
    let(:first)  { verses.first }
    let(:last)   { verses.to_a.last }

    it 'returns an enumerable of verses for this chapter' do
      expect(verses).to be_an(Enumerable)
      expect(first).to be_a(BibleXML::Verse)
      expect(first.num).to eq(1)
      expect(last.num).to eq(25)
    end
  end
end
