require_relative '../../spec_helper'

describe BibleParser::Book do
  let(:path)   { fixture_path('web.usfx.truncated.xml') }
  let(:file)   { File.open(path) }
  let(:parser) { BibleParser::Parsers::USFX::Parser.new(file) }

  subject { described_class.new(id: 'EXO', num: 2, title: 'Exodus', parser: parser) }

  describe '#id' do
    it 'returns the id' do
      expect(subject.id).to eq('EXO')
    end
  end

  describe '#each_chapter' do
    context 'without a block' do
      let(:chapters) { subject.each_chapter }
      let(:first)    { chapters.first }
      let(:last)     { chapters.to_a.last }

      it 'returns an enumerable of chapters for this book' do
        expect(chapters).to be_an(Enumerable)
        expect(first).to be_a(BibleParser::Chapter)
        expect(chapters.to_a)
        expect(first.num).to eq(1)
        expect(last.num).to eq(1)
      end
    end

    context 'with a block' do
      let(:chapters) { [] }

      before do
        subject.each_chapter do |chapter|
          chapters << chapter
        end
      end

      it 'yields to the block for each chapter' do
        expect(chapters.size).to eq(1)
        exo1 = chapters.first
        expect(exo1).to be_a(BibleParser::Chapter)
        expect(exo1.num).to eq(1)
        expect(chapters.last.num).to eq(1)
      end
    end
  end

  describe '#chapters' do
    let(:chapters) { subject.chapters }

    it 'returns an array of all chapters' do
      expect(chapters.size).to eq(1)
      exo1 = chapters.first
      expect(exo1).to be_a(BibleParser::Chapter)
      expect(exo1.num).to eq(1)
      expect(chapters.last.num).to eq(1)
    end
  end
end
