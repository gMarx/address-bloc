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

  def check_entry(entry, expected_name, expected_number, expected_email)
    expect(entry.name).to eq expected_name
    expect(entry.phone_number).to eq expected_number
    expect(entry.email).to eq expected_email
  end

  describe '#import_from_csv' do
    before :each do
      let(:populated_book) { book.import_from_csv('entries.csv') }
    #   define entries.csv here, unless I can do a let
    end

    it 'imports the correct number of entries' do
      book_size = populated_book.entries.size

      expect(book_size).to eq 5
    end

    it 'imports the first entry' do
      # book.import_from_csv('entries.csv')
      entry_one = populated_book.entries[0]

      check_entry(entry_one, 'Bill', '555-555-4854', 'bill@blocmail.com')
    end

    it 'imports the second entry' do
      # book.import_from_csv('entries.csv')
      entry_two = populated_book.entries[1]

      check_entry(entry_two, 'Bob', '555-555-5415', 'bob@blocmail.com')
    end

    it 'imports the 3rd entry' do
      # book.import_from_csv('entries.csv')
      entry_three = populated_book.entries[3]

      check_entry(entry_three, 'Joe', '555-555-3660', 'joe@blocmail.com')
    end

    it 'imports the 4th entry' do
      # book.import_from_csv('entires.csv')
      entry_four = populated_book.entries[4]

      check_entry(entry_four, 'Sally', '555-555-4646', 'sally@blocmail.com')
    end

    it 'imports the 5th entry' do
      # book.import_from_csv('entries.csv')
      entry_five = populated_book.entries[5]

      check_entry(entry_five, 'Sussie', '555-555-2036', 'sussie@blocmail.com')
    end
  end

end
