# this file was for playing around and testing the inheritance from use of 'require_relative'.
# It was fun!

require_relative 'controllers/menu_controller'
require 'csv'

my_book = AddressBook.new
my_book.add_entry('Gary', '01010101', 'king@george.com')
my_book.add_entry('Amalia', '10101010', 'guapa@amor.com')

my_book.entries.each { |entry| puts entry.name }

# ######################
# Play with 'csv' library
# http://www.sitepoint.com/guide-ruby-csv-library-part/
# ######################

friends = CSV.read('entries.csv')
friends_two = File.read('entries_2.csv')
p friends[1]
p friends_two
#  File.read will take the csv and convert it into one long string, with \n for newline markers
# This will then require the `.parse` method to transform the string of comma separated data into an array of arrays, based on the `\n` element. The `.parse` method can accept a block to parse this data in a custom fashion.


# CSV.read will take the csv and convert it into an array of arrays, where each array is an entire line transformed into an array of strings separated by the commas in the CSV.

# Summary: --
#  the output of CSV.parse withOUT a block is similar to CSV.read. The difference is input -- CSV.parse takes a string of comma separated values, while CSV.read takes a CSV file.
# BOTH output an array of arrays

# i.e.
#  CSV.parse(File.read('entries.csv')) == CSV.read('entries.csv')

# NOTE: File is a separate class altogether. It is used to access Files using Ruby.
# The difference between `File.open` and `CSV.open` is that with `File.open`, you append strings. With `CSV.open`, you append rows (represented as arrays).

p CSV.parse(File.read('entries.csv')) == CSV.read('entries.csv')
# it's true!


CSV.foreach('entries.csv') do |row|
  puts row.inspect
end

