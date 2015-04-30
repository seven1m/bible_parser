require_relative '../spec_helper'

describe BibleXML do
  context 'given a USFX formatted file' do
    let(:path) { fixture_path('web.usfx.truncated.xml') }

    subject { BibleXML.new(File.open(path)) }

    describe '#format' do
      it 'returns "USFX"' do
        expect(subject.format).to eq('USFX')
      end
    end

    describe '#books' do
      let(:books) { subject.books }

      it 'returns an enumerable of books' do
        expect(books).to be_an(Enumerator)
        genesis = books.first
        expect(genesis).to be_a(BibleXML::Book)
        expect(genesis.id).to eq('GEN')
        expect(books.to_a.size).to eq(2)
      end
    end
  end
end
