require_relative '../models/address_book'

class MenuController
  attr_accessor :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu
    puts "Main Menu - #{@address_book.entries.count} entries"
    puts '1 - View all entries'
    puts '2 - Create an entry'
    puts '3 - Search for an entry'
    puts '4 - Import entries form a CSV'
    puts '5 - View Entry Number (n):'
    puts '6 - Exit'
    print 'Enter your selection: '

    selection = gets.to_i
    puts "You picked #{selection}"
    case selection
    when 1
      system 'clear'
      view_all_entries
      main_menu
    when 2
      system 'clear'
      create_entry
      main_menu
    when 3
      system 'clear'
      search_entries
      main_menu
    when 4
      system 'clear'
      import_from_csv
      main_menu
    when 5
      system 'clear'
      view_entry_n
      main_menu
    when 6
      system 'clear'
      exit(0)
    else
      system 'clear'
      puts 'ERROR :: Please choose a number, between 1 and 5.'
      main_menu
    end
  end

  def view_all_entries
    @address_book.entries.each do |entry|
      system 'clear'
      puts entry.to_s

      entry_submenu(entry)
    end

    system 'clear'
    puts 'that\'s all the people you know!'
    puts ''
  end

  def view_entry_n
    puts 'What entry would you like to see? (Counting starts at 1) '
    selection = gets.to_i

    if selection == 0
      system 'clear'
      puts 'Error :: Please enter a valid number, 1 or greater. Please try again.'

      view_entry_n
    elsif @address_book.entries.length < (selection - 1)
      system 'clear'
      puts 'Error :: You\'ve chosen a number outside of the range. Please try again.'

      view_entry_n
    else
      puts @address_book.entries[selection - 1].to_s
    end

  end

  def create_entry
    system 'clear'
    puts 'New AddressBloc Entry'
    print 'What is the person\'s name? '
    name = gets.chomp
    print 'what is the person\'s phone number? '
    phone_number = gets.chomp
    print 'what is the person\'s email? '
    email = gets.chomp

    @address_book.add_entry(name, phone_number, email)

    system 'clear'
    puts 'New Entry Created!'

  end
  def search_entries

  end
  def import_from_csv

  end

  def entry_submenu(entry)
    puts 'n - next entry'
    puts 'd - delete entry'
    puts 'e - edit this entry'
    puts 'm - return to main menu'

    selection = gets.chomp

    case selection
    when 'n'
    when 'd'
    when 'e'
    when 'm'
      main_menu
    else
      system 'clear'
      puts "#{selection} is not valid. Please try again."
      entry_submenu(entry)
    end
  end

end
