require_relative '../spec_helper'

describe BibleParser do
  context 'given a USFX formatted file' do
    let(:path) { fixture_path('web.usfx.truncated.xml') }

    subject { BibleParser.new(File.open(path)) }

    describe '#format' do
      it 'returns "USFX"' do
        expect(subject.format).to eq('USFX')
      end
    end

    describe '#books' do
      let(:books) { subject.books }

      it 'returns an array of all books' do
        expect(books.size).to eq(2)
        genesis = books.first
        expect(genesis).to be_a(BibleParser::Book)
        expect(genesis.id).to eq('GEN')
        expect(genesis.title).to eq('Genesis')
        expect(books.to_a.size).to eq(2)
      end

      it 'parses chapters for each book' do
        genesis = books.first
        expect(genesis.chapters.size).to eq(1)
      end
    end

    describe '#each_book' do
      context 'without a block' do
        let(:books) { subject.each_book }

        it 'returns an enumerable of books' do
          expect(books).to be_an(Enumerator)
          genesis = books.first
          expect(genesis).to be_a(BibleParser::Book)
          expect(genesis.id).to eq('GEN')
          expect(books.to_a.size).to eq(2)
        end
      end

      context 'with a block' do
        let(:books) { [] }

        before do
          subject.each_book do |book|
            books << book
          end
        end

        it 'yields to the block for each book' do
          expect(books.size).to eq(2) # only 2 books in our sample
          genesis = books.first
          expect(genesis).to be_a(BibleParser::Book)
          expect(genesis.id).to eq('GEN')
        end
      end
    end

    describe '#verses' do
      let(:verses) { subject.verses }

      it 'returns an array of all verses' do
        expect(verses.size).to eq(4) # only 4 verses in our sample
        gen1_1 = verses.first
        expect(gen1_1).to be_a(BibleParser::Verse)
        expect(gen1_1.num).to eq(1)
        expect(gen1_1.chapter_num).to eq(1)
        expect(gen1_1.book_num).to eq(1)
        expect(gen1_1.book_id).to eq('GEN')
      end
    end

    describe '#each_verse' do
      context 'without a block' do
        let(:verses) { subject.each_verse }

        it 'returns an enumerable of verses' do
          expect(verses).to be_an(Enumerable)
          gen1_1 = verses.first
          expect(gen1_1).to be_a(BibleParser::Verse)
          expect(gen1_1.num).to eq(1)
          expect(gen1_1.chapter_num).to eq(1)
          expect(gen1_1.book_num).to eq(1)
          expect(gen1_1.book_id).to eq('GEN')
        end
      end

      context 'with a block' do
        let(:verses) { [] }

        before do
          subject.each_verse do |verse|
            verses << verse
          end
        end

        it 'yields to the block for each verse' do
          expect(verses.size).to eq(4) # only 4 verses in our sample
          gen1_1 = verses.first
          expect(gen1_1).to be_a(BibleParser::Verse)
          expect(gen1_1.num).to eq(1)
          expect(gen1_1.chapter_num).to eq(1)
          expect(gen1_1.book_num).to eq(1)
          expect(gen1_1.book_id).to eq('GEN')
        end
      end
    end
  end

  context 'given a OSIS formatted file' do
    let(:path) { fixture_path('kjv.osis.truncated.xml') }

    subject { BibleParser.new(File.open(path)) }

    describe '#format' do
      it 'returns "OSIS"' do
        expect(subject.format).to eq('OSIS')
      end
    end

    describe '#books' do
      let(:books) { subject.books }

      it 'returns an array of all books' do
        expect(books.size).to eq(3)
        genesis = books.first
        expect(genesis).to be_a(BibleParser::Book)
        expect(genesis.id).to eq('GEN')
        expect(genesis.title).to eq('Genesis')
      end

      it 'parses chapters for each book' do
        genesis = books.first
        expect(genesis.chapters.size).to eq(1)
      end

      it 'returns proper book ids' do
        expect(books.last.id).to eq('JDG')
      end
    end

    describe '#verses' do
      let(:verses) { subject.verses }

      it 'returns an array of all verses' do
        expect(verses.size).to eq(7) # only 7 verses in our sample
        gen1_1 = verses.first
        expect(gen1_1).to be_a(BibleParser::Verse)
        expect(gen1_1.num).to eq(1)
        expect(gen1_1.chapter_num).to eq(1)
        expect(gen1_1.book_num).to eq(1)
        expect(gen1_1.book_id).to eq('GEN')
      end
    end
  end

  context 'given a `Zefania XML Bible Markup Language` formatted file' do
    let(:path) { fixture_path('nl-statenvertaling.zefania.truncated.xml') }

    subject { BibleParser.new(File.open(path)) }

    describe '#format' do
      it 'returns "ZXBML"' do
        expect(subject.format).to eq('ZXBML')
      end
    end

    describe '#books' do
      let(:books) { subject.books }

      it 'returns an array of all books' do
        expect(books.size).to eq(3)
        genesis = books.first
        expect(genesis).to be_a(BibleParser::Book)
        expect(genesis.id).to eq('GEN')
        expect(genesis.title).to eq('1 Mose')
      end

      it 'parses chapters for each book' do
        genesis = books.first
        expect(genesis.chapters.size).to eq(1)
      end

      it 'returns proper book ids' do
        expect(books.last.id).to eq('JDG')
      end
    end

    describe '#verses' do
      let(:verses) { subject.verses }

      it 'returns an array of all verses' do
        expect(verses.size).to eq(7) # only 7 verses in our sample
        gen1_1 = verses.first
        expect(gen1_1).to be_a(BibleParser::Verse)
        expect(gen1_1.num).to eq(1)
        expect(gen1_1.chapter_num).to eq(1)
        expect(gen1_1.book_num).to eq(1)
        expect(gen1_1.book_id).to eq('GEN')
      end
    end
  end
end
