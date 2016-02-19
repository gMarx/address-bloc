require_relative '../models/address_book'

RSpec.describe AddressBook do
  # setup for common parameters through tests
  let(:book) { AddressBook.new }

  describe 'attributes' do
    it 'should respond to entries' do
      expect(book).to respond_to(:entries)
    end

    it 'should initialize entries as an array' do
      expect(book.entries).to be_an(Array)
    end

    it 'initializes entries as empty' do
      expect(book.entries.size).to eq(0)
    end
  end

  describe '#add_entry' do
    before :each do
      book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
    end

    it 'adds only one entry to the address book' do
      expect(book.entries.size).to eq(1)
    end

    it 'adds the correct information to entries' do
      new_entry = book.entries[0]

      expect(new_entry.name).to eq('Ada Lovelace')
      expect(new_entry.phone_number).to eq('010.012.1815')
      expect(new_entry.email).to eq('augusta.king@lovelace.com')
    end
  end

  describe '#remove_entry' do
    before :each do
      book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
    end

    it 'removes the desired entry' do
      deleted_entry = book.remove_entry('Ada Lovelace')
      expect(book.entries.size).to eq(0)
    end

    it 'removes when there multple entries' do
      # setup
      book.add_entry('Alfred Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
      book.add_entry('Jon Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
      book.add_entry('Jim Lovelace', '010.012.1815', 'augusta.king@lovelace.com')

      expect(book.entries.size).to eq(4)
      # do it
      deleted_entry = book.remove_entry('Jon Lovelace')

      # check results
      expect(book.entries.size).to eq(3)
    end
  end
end
