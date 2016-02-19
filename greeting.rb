def hello
  ARGV.each do |arg|
    puts "Hey #{arg}"
  end
end

hello
