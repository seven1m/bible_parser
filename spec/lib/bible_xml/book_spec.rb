require_relative '../../spec_helper'

describe BibleXML::Book do
  let(:path)   { fixture_path('web.usfx.truncated.xml') }
  let(:file)   { File.open(path) }
  let(:parser) { BibleXML::Parsers::USFX::Parser.new(file) }

  subject { described_class.new(id: 'EXO', num: 2, title: 'Exodus', parser: parser) }

  describe '#id' do
    it 'returns the id' do
      expect(subject.id).to eq('EXO')
    end
  end

  describe '#chapters' do
    let(:chapters) { subject.chapters }
    let(:first)    { chapters.first }
    let(:last)     { chapters.to_a.last }

    it 'returns an enumerable of chapters for this book' do
      expect(chapters).to be_an(Enumerable)
      expect(first).to be_a(BibleXML::Chapter)
      expect(chapters.to_a)
      expect(first.num).to eq(1)
      expect(last.num).to eq(40)
    end
  end
end
