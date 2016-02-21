require_relative 'entry'
require 'csv'

class AddressBook

  attr_reader :entries
  def initialize
    @entries = []
  end

  def add_entry(name, phone_number, email)
    index = 0
    @entries.each do |entry|
      if name < entry.name
        break
      end
      index += 1
    end

    @entries.insert(index, Entry.new(name, phone_number, email))
  end

  def remove_entry(name)
    @entries.each_with_index do |entry, i|
      if name == entry.name
        @index = i
        break
      end
    end

    @entries.delete_at(@index)
  end

  def import_from_csv(file_name)
    csv_text = File.read(file_name)
    # the first row is a header, which is what the option `headers: true` signals, telling the CSV.parse to treat the 1st row differently.
    # This will change the output from an array of arrays to a table of row objects, each representing a row.

    csv = CSV.parse(csv_text, headers: true, skip_blanks: true)

    csv.each do |row|
      row_hash = row.to_hash
      add_entry(row_hash['name'], row_hash['phone_number'], row_hash['email'])

    end
  end

  def binary_search(name)

    lower = 0
    upper = entries.length - 1

    while lower <= upper
      mid = (lower + upper) / 2
      mid_name = entries[mid].name

      if name == mid_name
        return entries[mid]
      elsif name < mid_name
        upper = mid - 1
      else
        lower = mid + 1
      end

      nil
    end
  end

  def iterative_search(name)
    entries.each do |entry|
      return entry if entry.name == name
    end
    return nil
  end

  def hash_search(name)

    # entries.each do |entry|
      # puts entry.to_s
    # end
  end
end
