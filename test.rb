# this file was for playing around and testing the inheritance from use of 'require_relative'.
# It was fun!

require_relative 'controllers/menu_controller'

my_book = AddressBook.new
my_book.add_entry('Gary', '01010101', 'king@george.com')
my_book.add_entry('Amalia', '10101010', 'guapa@amor.com')

my_book.entries.each { |entry| puts entry.name }
