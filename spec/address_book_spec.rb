require_relative '../models/address_book'

RSpec.describe AddressBook do
  # setup for common parameters through tests
  let(:book) { AddressBook.new }

  def check_entry(entry, expected_name, expected_number, expected_email)
    expect(entry.name).to eq expected_name
    expect(entry.phone_number).to eq expected_number
    expect(entry.email).to eq expected_email
  end

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

    it 'removes when there are multiple entries' do
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



  describe '#import_from_csv' do
    context 'entries.csv should be valid' do

      it 'imports the correct number of entries' do
        book.import_from_csv('entries.csv')
        book_size = book.entries.size

        expect(book_size).to eq 5
      end

      it 'imports the first entry' do
        book.import_from_csv('entries.csv')
        entry_one = book.entries[0]

        check_entry(entry_one, 'Bill', '555-555-4854', 'bill@blocmail.com')
      end

      it 'imports the second entry' do
        book.import_from_csv('entries.csv')
        entry_two = book.entries[1]

        check_entry(entry_two, 'Bob', '555-555-5415', 'bob@blocmail.com')
      end

      it 'imports the third entry' do
        book.import_from_csv('entries.csv')
        entry_three = book.entries[2]

        check_entry(entry_three, 'Joe', '555-555-3660', 'joe@blocmail.com')
      end

      it 'imports the fourth entry' do
        book.import_from_csv('entries.csv')
        entry_four = book.entries[3]

        check_entry(entry_four, 'Sally', '555-555-4646', 'sally@blocmail.com')
      end

      it 'imports the fifth entry' do
        book.import_from_csv('entries.csv')
        entry_five = book.entries[4]

        check_entry(entry_five, 'Sussie', '555-555-2036', 'sussie@blocmail.com')
      end
    end

    context 'entries_2 should be valid' do
      it 'imports the correct number of entries' do
        book.import_from_csv('entries_2.csv')
        book_size = book.entries.size

        expect(book_size).to eq 3
      end

      it 'imports the 1st entry' do
        book.import_from_csv('entries_2.csv')
        entry_one = book.entries[0]

        check_entry(entry_one, 'Blanca', '818-818-8765', 'blanca@blanch.com' )
      end

      it 'imports the 2nd entry' do
        book.import_from_csv('entries_2.csv')
        entry_two = book.entries[1]

        check_entry(entry_two, 'Erin', '743-743-5555', 'erin@erin.com' )
      end

      it 'imports the 3rd entry' do
        book.import_from_csv('entries_2.csv')
        entry_three = book.entries[2]

        check_entry(entry_three, 'Gary', '415-867-5309', 'gary@gary.com')
      end
    end
  end

  describe '#binary_search' do
    before :each do
      book.import_from_csv('entries.csv')
    end
    context 'search AddressBook' do
      it 'should return nil for a non-existent entry' do
        # book.import_from_csv('entries.csv')
        entry = book.binary_search('Dan')

        expect(entry).to be_nil
      end

      it 'should be nil for Billy' do
        entry = book.binary_search('Billy')
        expect(entry).to be_nil
      end

      it 'should return an entry for Bill' do
        # book.import_from_csv('entries.csv')
        entry = book.binary_search('Bill')
        expect(entry).to be_a Entry
        check_entry(entry, 'Bill', '555-555-4854', 'bill@blocmail.com')
      end

      it 'should return an entry for Bob' do
        entry = book.binary_search('Bob')
        expect(entry).to be_a Entry
        check_entry(entry, 'Bob', '555-555-5415', 'bob@blocmail.com')
      end

      it 'should return an entry for Joe' do
        entry = book.binary_search('Joe')
        expect(entry).to be_a Entry
        check_entry(entry, 'Joe', '555-555-3660', 'joe@blocmail.com')
      end

      it 'should return an entry for Sally' do
        entry = book.binary_search('Sally')
        expect(entry).to be_a Entry
        check_entry(entry, 'Sally', '555-555-4646', 'sally@blocmail.com')
      end

      it 'should return an entry for Sussie' do
        entry = book.binary_search('Sussie')
        expect(entry).to be_a Entry
        check_entry(entry, 'Sussie', '555-555-2036', 'sussie@blocmail.com')
      end
    end
  end

  describe '#iterative_search' do
    context 'search AddressBook' do
      before :each do
        book.import_from_csv('entries.csv')
      end

      it 'should return nil for non-existent entry' do
        entry = book.iterative_search('Paul')
        expect(entry).to be_nil
      end

      it 'should be nil for Billy' do
        entry = book.iterative_search('Billy')
        expect(entry).to be_nil
      end

      it 'should return an entry for Bill' do
        entry = book.iterative_search('Bill')
        expect(entry).to be_a Entry
        check_entry(entry, 'Bill', '555-555-4854', 'bill@blocmail.com' )
      end

      it 'should return an entry for Bob' do
        entry = book.iterative_search('Bob')
        expect(entry).to be_a Entry
        check_entry(entry, 'Bob', '555-555-5415', 'bob@blocmail.com')
      end

      it 'should return an entry for Joe' do
        entry = book.iterative_search('Joe')
        expect(entry).to be_a Entry
        check_entry(entry, 'Joe', '555-555-3660', 'joe@blocmail.com')
      end

      it 'should return an entry for Sally' do
        entry = book.iterative_search('Sally')
        expect(entry).to be_a Entry
        check_entry(entry, 'Sally', '555-555-4646', 'sally@blocmail.com')
      end

      it 'should return an entry for Sussie' do
        entry = book.iterative_search('Sussie')
        expect(entry).to be_a Entry
        check_entry(entry, 'Sussie', '555-555-2036', 'sussie@blocmail.com')
      end
    end
  end

  # describe '#hash_search' do
  #   context 'search AddressBook' do
  #     before :each do
  #       book.import_from_csv('entries.csv')
  #     end
  #
  #     it 'should return nil for non-existent entry' do
  #       entry = book.hash_search('Paul')
  #       expect(entry).to be_nil
  #     end
  #
  #     it 'should be nil for Billy' do
  #       entry = book.hash_search('Billy')
  #       expect(entry).to be_nil
  #     end
  #
  #     it 'should return an entry for Bill' do
  #       entry = book.hash_search('Bill')
  #       expect(entry).to be_a Entry
  #       check_entry(entry, 'Bill', '555-555-4854', 'bill@blocmail.com' )
  #     end
  #
  #     it 'should return an entry for Bob' do
  #       entry = book.hash_search('Bob')
  #       expect(entry).to be_a Entry
  #       check_entry(entry, 'Bob', '555-555-5415', 'bob@blocmail.com')
  #     end
  #
  #     it 'should return an entry for Joe' do
  #       entry = book.hash_search('Joe')
  #       expect(entry).to be_a Entry
  #       check_entry(entry, 'Joe', '555-555-3660', 'joe@blocmail.com')
  #     end
  #
  #     it 'should return an entry for Sally' do
  #       entry = book.hash_search('Sally')
  #       expect(entry).to be_a Entry
  #       check_entry(entry, 'Sally', '555-555-4646', 'sally@blocmail.com')
  #     end
  #
  #     it 'should return an entry for Sussie' do
  #       entry = book.hash_search('Sussie')
  #       expect(entry).to be_a Entry
  #       check_entry(entry, 'Sussie', '555-555-2036', 'sussie@blocmail.com')
  #     end
  #   end
  # end

end
